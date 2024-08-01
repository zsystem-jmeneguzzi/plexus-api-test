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
            //"archivos" => env("APP_URL")."storage/".$this->resource->archivos,
            // "person" => $this->resource->person ? [
            //     "id" => $this->resource->id,
            //     "patient_id" => $this->resource->patient_id,
            //     "name_companion" => $this->resource->name_companion,
            //     "surname_companion" => $this->resource->surname_companion,
            //     "mobile_companion" => $this->resource->mobile_companion,
            //     "relationship_companion" => $this->resource->relationship_companion,
            //     "name_responsible" => $this->resource->name_responsible,
            //     "surname_responsible" => $this->resource->surname_responsible,
            //     "mobile_responsible" => $this->resource->mobile_responsible,
            //     "relationship_responsible" => $this->resource->relationship_responsible,
            // ]:NULL,
            "created_at" => $this->resource->created_at->format("Y-m-d h:i A")
        ];
    }
  

    }

