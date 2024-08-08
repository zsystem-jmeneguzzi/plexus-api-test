<?php

namespace App\Providers;

use Illuminate\Support\Facades\Gate;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use App\Models\Carpetas\Carpetas;
use App\Models\IngresoEgreso;
use App\Policies\CarpetaPolicy;
use App\Policies\IngresoEgresoPolicy;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        Carpetas::class => CarpetaPolicy::class,
        IngresoEgreso::class => IngresoEgresoPolicy::class,
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot(): void
{
    $this->registerPolicies();

    Gate::before(function($user, $ability) {
        return $user->hasRole("Super-Admin") ? true : null;
    });
}

}
