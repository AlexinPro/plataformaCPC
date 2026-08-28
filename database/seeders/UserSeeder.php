<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $password = env('SEEDER_USER_PASSWORD');
        if (empty($password)) {
            throw new \RuntimeException(
                'SEEDER_USER_PASSWORD no está configurada.'
            );
        }

        $users = [
            [
                'name' => 'Juan Perez',
                'email' => 'admin@test.com',
                'role' => 'super_admin',
            ],
            [
                'name' => 'Super Admin Prueba',
                'email' => 'superadmin@plataformacpc.test',
                'role' => 'super_admin',
            ],
            [
                'name' => 'Jesus Alejandro',
                'email' => 'jesus.alejandro@plataformacpc.test',
                'role' => 'admin',
            ],
            [
                'name' => 'Admin Prueba',
                'email' => 'admin@plataformacpc.test',
                'role' => 'admin',
            ],
            [
                'name' => 'Usuario Integrante',
                'email' => 'integrante@ejemplo.com',
                'role' => 'integrante',
            ],
            [
                'name' => 'Integrante Prueba',
                'email' => 'integrante.prueba@plataformacpc.test',
                'role' => 'integrante',
            ],
        ];

        foreach ($users as $data) {
            $user = User::updateOrCreate(
                ['email' => $data['email']],
                [
                    'name' => $data['name'],
                    'password' => Hash::make($password),
                ]
            );
            $user->syncRoles([$data['role']]);
        }
    }
}