<?php

namespace App\Http\Resources\Carpeta;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CarpetaResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            "id" => $this->resource->id,
            "autos" => $this->resource->autos,
            "nro_carpeta" => $this->resource->nro_carpeta,
            "fecha_inicio" => Carbon::parse($this->resource->fecha_inicio)->format("Y/m/d"),
            "tipo_proceso_id" => $this->resource->tipo_proceso_id,
            "estado" => $this->resource->estado,
            "descripcion" => $this->resource->descripcion,
            "abogado_id" => $this->resource->abogado_id,
            "contrarios_id" => $this->resource->contrarios_id,
            "ultimo_movimiento" => $this->resource->ultimo_movimiento,
            "tercero_id" => $this->resource->tercero_id,
           "cliente_id" => $this->resource->cliente_id,
            "created_at" => $this->resource->created_at->format("Y-m-d h:i A")
        ];
    }


    }

