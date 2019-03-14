<template>
    <div class="container todolist">
        <div class="row justify-content-center">
            <div class="col-md-12">
               <div class="row todolist__new-task">
                   <div class="col-md-12">
                       <b-alert variant="danger" v-if="errors" show>
                           <template v-for="error in errors">
                               <p v-for="errorItem in error">{{errorItem}}</p>
                           </template>
                       </b-alert>
                   </div>
                   <div class="col-md-9">
                       <b-form-input v-model="newTaskName" type="text" placeholder="Enter Task Name" />
                   </div>
                   <div class="col-md-3">
                        <b-button class="todolist__new-task__button" @click="createTask" variant="success">submit</b-button>
                   </div>
                   <div class="col-md-12">
                       <b-form-textarea
                               id="textarea"
                               v-model="newTaskDescription"
                               placeholder="Enter Task Description"
                               class="todolist__new-task__textarea"
                               rows="3"
                               max-rows="6"
                       />
                   </div>
               </div>
                <div class="col-md-12">
                    <div class="row todolist__tasks">
                        <div class="col-md-6" v-for="task in taskList">
                            <b-card v-bind:title="task.name" class="mb-4">
                                <b-card-text v-bind:class="{'todolist__tasks__done': task.done_at }">
                                    {{task.description}}
                                </b-card-text>
                                <b-button
                                        v-if="!task.done_at"
                                        variant="info"
                                        size="sm"
                                        @click="doneTask(task.id)">
                                    done
                                </b-button>
                                <b-button
                                        v-if="task.done_at"
                                        variant="warning"
                                        size="sm"
                                        @click="undoneTask(task.id)">
                                    undone
                                </b-button>
                                <b-button
                                        class="todolist__tasks__right"
                                        size="sm"
                                        variant="danger"
                                        @click="deleteTask(task.id)">
                                    delete
                                </b-button>
                            </b-card>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                newTaskName: '',
                newTaskDescription: '',
                taskList: null,
                errors: null
            };
        },
        created() {
            this.getTasks();

        },
        mounted() {
        },
        methods: {
            getTasks() {
                axios.get('/tasks')
                    .then(response => {
                        this.taskList = response.data;
                    })
            },
            createTask() {
                axios.post('/tasks',{name: this.newTaskName, description: this.newTaskDescription})
                    .then(response => {
                        this.getTasks();
                        this.clearForm();
                    })
                    .catch(error => {
                       this.errors = error.response.data.errors;
                    });
            },
            doneTask(id) {
                axios.post('task/'+ id +'/done')
                    .then(response => {
                        this.getTasks();
                    })
            },
            undoneTask(id) {
                axios.post('task/'+ id +'/undone')
                    .then(response => {
                        this.getTasks();
                    })
            },
            deleteTask(id) {
                axios.delete('tasks/'+ id)
                    .then(response => {
                        this.getTasks();
                    })
            },
            clearForm() {
                this.newTaskName = '';
                this.newTaskDescription = '';
            }
        }
    }
</script>
<style lang="scss">
    .todolist {
        &__new-task {

            padding: 20px;

            &__button {
                width: 100%;
            }

            &__textarea {
                margin-top: 20px;
            }
        }
        &__tasks {
            &__done {
                text-decoration: line-through;
            }
            &__right {
                float: right;
            }
        }
    }
</style>
