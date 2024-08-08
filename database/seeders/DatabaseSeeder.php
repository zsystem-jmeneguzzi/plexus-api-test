<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {

        Permission::firstOrCreate(['name' => 'carpeta_List', 'guard_name' => 'api']);
        Permission::firstOrCreate(['name' => 'carpeta_Create', 'guard_name' => 'api']);
        Permission::firstOrCreate(['name' => 'carpeta_Update', 'guard_name' => 'api']);
        Permission::firstOrCreate(['name' => 'carpeta_Delete', 'guard_name' => 'api']);

         $role = Role::firstOrCreate(['name' => 'Abogado', 'guard_name' => 'api']);
         $permissions = [
            'carpeta_List',
            'carpeta_Create',
            'carpeta_Update',
            'carpeta_Delete',
            'resumen_List', // Nuevo permiso
            'resumen_Create', // Nuevo permiso
            'resumen_Update', // Nuevo permiso
            'resumen_Delete', // Nuevo permiso
            'income_expense_summary'
        ];
        foreach ($permissions as $permission) {
            $perm = Permission::firstOrCreate(['name' => $permission, 'guard_name' => 'api']);
            $role->givePermissionTo($perm);
        }
        $role = Role::firstOrCreate(['name' => 'Abogado', 'guard_name' => 'api']);
         $role->givePermissionTo(['carpeta_List', 'carpeta_Create', 'carpeta_Update', 'carpeta_Delete']);

    }
}
