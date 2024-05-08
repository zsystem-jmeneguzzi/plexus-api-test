<?php

namespace App\Console\Commands;

use Carbon\Carbon;
use Illuminate\Console\Command;
use App\Models\Appointment\Appointment;

class NotificationAppointmentsWhatsapp extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:notification-appointments-whatsapp';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Notificar al cliente 1 hora antes de su cita x Whatsapp';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        date_default_timezone_set('America/Argentina/Buenos_Aires');
        $simulate = date("2024-04-22 13:55:35");
        $appointments = Appointment::whereDate("date_appointment",now()->format("Y-m-d"))
                                    ->where("status",1)
                                    ->get();
        $now_time_number = strtotime(now()->format("Y-m-d h:i:s")); //now()->format("Y-m-d h:i:s"));
        $patients = collect([]);
        $patient = collect([]);
        foreach($appointments as $key => $appointment){
            $hour_start = $appointment->doctor_schedule_join_hour->doctor_schedule_hour->hour_start;
            $hour_end = $appointment->doctor_schedule_join_hour->doctor_schedule_hour->hour_end;

            $hour_start = strtotime(Carbon::parse(date("Y-m-d")." ".$hour_start)->subHour());
            $hour_end = strtotime(Carbon::parse(date("Y-m-d")." ".$hour_end)->subHour());

            if($hour_start <= $now_time_number && $hour_end >= $now_time_number){
                $patients->push([
                    "name" => $appointment->patient->name,
                    "surname" => $appointment->patient->surname,
                    "avatar" => $appointment->avatar ? env("APP_URL")."storage/".$appointment->avatar : NULL,
                    "email" => $appointment->patient->email,
                    "mobile" => $appointment->patient->mobile,
                    "doctor" => $appointment->doctor->name,
                    "specialitie_name" => $appointment->specialitie->name,
                    "n_document" => $appointment->patient->n_document,
                    "hour_start_format" => Carbon::parse(date("Y-m-d")." ".$appointment->doctor_schedule_join_hour->doctor_schedule_hour->hour_start)->format("h:i A"),
                    "hour_end_format" => Carbon::parse(date("Y-m-d")." ".$appointment->doctor_schedule_join_hour->doctor_schedule_hour->hour_end)->format("h:i A"),
                ]);
            }
        }





        foreach ($patients as $key => $patient) {

            $accessToken = 'EAANZBfN4PJjABO2nnFB29sAZBU3UGYJdNZCOs75X5Y42iXChWBMZBYd3jvcAhLujbWvi0kybMeTMdrzciZB2SwLQfW3ypXEPdZBesvQa20eTPidzAZAKmvKxz8T4ZCxPzYzlAOVedxI0tep5R0Ji0rTf9p0j4WjPEXyaOnxIjc7ZBw2NwkNEZAbcNvW2mjRffcFyJu';

        $fbApiUrl = 'https://graph.facebook.com/v18.0/277385565465325/messages';

        $data = [
            'messaging_product' => 'whatsapp',
            'to' => $patient[mobile],
            'type' => 'template',
            'template' => [
                'name' => 'recordatorio',
                'language' => [
                    'code' => 'es_AR',
                ],
                "components"=>  [

                    [
                        "type" => "body",
                        "parameters" => [
                            [
                                "type"=> "text",
                                "text"=>  $patient["hour_start_format"], //Hora de la cita
                            ],
                            [
                                "type"=> "text",
                                "text"=>  $patient["doctor"], // Nombre del doctor
                            ],
                        ]
                    ],
                ],
            ],
        ];

        $headers = [
            'Authorization: Bearer ' . $accessToken,
            'Content-Type: application/json',
        ];

        $ch = curl_init($fbApiUrl);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        curl_close($ch);

        echo "HTTP Code: $httpCode\n";
        echo "Response:\n$response\n";



        }

        dd($patients);
    }
    }





