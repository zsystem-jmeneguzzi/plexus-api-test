<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Carpetas\Carpetas;
use Illuminate\Auth\Access\HandlesAuthorization;

class CarpetaPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user)
    {
        return $user->hasRole('Super-Admin') || $user->hasPermissionTo('carpeta_List');
    }

    public function view(User $user, Carpetas $carpeta)
    {
        return $user->hasRole('Super-Admin') || $user->id === $carpeta->abogado_id;
    }

    public function create(User $user)
    {
        return $user->hasRole('Super-Admin') || $user->hasPermissionTo('carpeta_Create');
    }


    public function update(User $user, Carpetas $carpeta)
{
    return $user->hasRole('Super-Admin') || $user->id === $carpeta->abogado_id || $user->hasPermissionTo('carpeta_Update');
}



    public function delete(User $user, Carpetas $carpeta)
    {
        return $user->hasRole('Super-Admin') || $user->id === $carpeta->abogado_id;
    }
}
