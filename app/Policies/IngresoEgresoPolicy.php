<?php
// app/Policies/IngresoEgresoPolicy.php
namespace App\Policies;

use App\Models\IngresoEgreso;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class IngresoEgresoPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user)
    {
        return $user->hasRole('Superadmin') || $user->can('resumen_List');
    }

    public function view(User $user, IngresoEgreso $ingresoEgreso)
    {
        return $user->hasRole('Superadmin') || $user->can('resumen_List');
    }

    public function create(User $user)
    {
        return $user->hasRole('Superadmin') || $user->can('resumen_Create');
    }

    public function update(User $user, IngresoEgreso $ingresoEgreso)
    {
        return $user->hasRole('Superadmin') || $user->can('resumen_Update');
    }

    public function delete(User $user, IngresoEgreso $ingresoEgreso)
    {
        return $user->hasRole('Superadmin') || $user->can('resumen_Delete');
    }
}
