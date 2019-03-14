<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
class Task extends Model
{

    protected $fillable = [
        'name', 'description','done_at'
    ];
    /**
     * @var array
     */
    protected $dates = [
        'created_at',
        'updated_at',
        'done_at'
    ];

}