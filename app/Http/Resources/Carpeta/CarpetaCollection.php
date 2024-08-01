<?php

namespace App\Http\Resources\Carpeta;

use Illuminate\Http\Request;
use App\Http\Resources\Carpeta\CarpetaResource;
use Illuminate\Http\Resources\Json\ResourceCollection;

class CarpetaCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            "data" => CarpetaResource::collection($this->collection),
        ];
    }
}
