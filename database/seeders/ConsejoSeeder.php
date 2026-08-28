<?php

namespace Database\Seeders;

use App\Models\Consejo;
use Illuminate\Database\Seeder;

class ConsejoSeeder extends Seeder
{
    public function run(): void
    {
        $consejos = [
            [
                'id' => 1,
                'nombre' => 'Asuntos Indígenas',
                'descripcion' => 'Fomentar la participación, reconocimiento y preservación de los derechos, culturas y lenguas de los pueblos indígenas que habitan en el municipio de Puebla Capital.',
            ],
            [
                'id' => 2,
                'nombre' => 'Bienestar',
                'descripcion' => 'Proponer acciones para mejorar las condiciones de vida de la población mediante el acceso a servicios básicos, programas sociales y desarrollo comunitario de nuestra ciudad.',
            ],
            [
                'id' => 3,
                'nombre' => 'Bienestar Animal',
                'descripcion' => 'Impulsar políticas de protección, cuidado y trato digno hacia los animales, promoviendo la tenencia responsable y la conciencia ciudadana.',
            ],
            [
                'id' => 4,
                'nombre' => 'Centro Histórico y Patrimonio Edificado',
                'descripcion' => 'Coadyuvar en la conservación, rehabilitación y aprovechamiento del patrimonio arquitectónico y cultural del centro histórico de la ciudad.',
            ],
            [
                'id' => 5,
                'nombre' => 'Cultura',
                'descripcion' => 'Fomentar el acceso a la vida cultural del municipio, el fortalecimiento de las expresiones artísticas y el patrimonio cultural.',
            ],
            [
                'id' => 6,
                'nombre' => 'Deporte',
                'descripcion' => 'Promover el deporte y la actividad física como medios para mejorar la salud, la convivencia y el desarrollo comunitario.',
            ],
            [
                'id' => 7,
                'nombre' => 'Derechos Humanos e Igualdad entre Géneros',
                'descripcion' => 'Fortalecer la cultura de derechos humanos, la no discriminación y la igualdad sustantiva.',
            ],
            [
                'id' => 8,
                'nombre' => 'Desarrollo Urbano',
                'descripcion' => 'Participar en la planeación del crecimiento ordenado del municipio, proponiendo estrategias para un desarrollo urbano sostenible e incluyente.',
            ],
            [
                'id' => 9,
                'nombre' => 'Desempeño Gubernamental',
                'descripcion' => 'Promover mejoras en la eficiencia, transparencia y rendición de cuentas del gobierno municipal.',
            ],
            [
                'id' => 10,
                'nombre' => 'Discapacidad',
                'descripcion' => 'Promover la inclusión plena de personas con discapacidad, eliminando barreras físicas, sociales y culturales en la vida municipal.',
            ],
            [
                'id' => 11,
                'nombre' => 'Ecología y Medio Ambiente',
                'descripcion' => 'Promover políticas y acciones de educación ecológica y desarrollo sustentable.',
            ],
            [
                'id' => 12,
                'nombre' => 'Educación',
                'descripcion' => 'Contribuir a la mejora del sistema educativo municipal, el acceso equitativo a la educación y la permanencia escolar.',
            ],
            [
                'id' => 13,
                'nombre' => 'Juventud',
                'descripcion' => 'Fomentar el acceso a la vida cultural del municipio, el fortalecimiento de las expresiones artísticas y el patrimonio cultural.',
            ],
            [
                'id' => 14,
                'nombre' => 'Niñez y Adolescencia',
                'descripcion' => 'Promover acciones y políticas que garanticen los derechos, bienestar y desarrollo integral de las infancias y adolescencias en el municipio.',
            ],
            [
                'id' => 15,
                'nombre' => 'Obras y Servicios Públicos',
                'descripcion' => 'Promover mejoras en la infraestructura, mantenimiento y calidad de los servicios públicos municipales.',
            ],
            [
                'id' => 16,
                'nombre' => 'Movilidad',
                'descripcion' => 'Proponer soluciones integrales para una movilidad segura, eficiente, equitativa y sustentable en la ciudad.',
            ],
            [
                'id' => 17,
                'nombre' => 'Personas en Situación de Vulnerabilidad',
                'descripcion' => 'Impulsar propuestas para mejorar las condiciones de vida y promover la inclusión de personas en condiciones de vulnerabilidad.',
            ],
            [
                'id' => 18,
                'nombre' => 'Protección Civil',
                'descripcion' => 'Impulsar acciones de prevención y respuesta ante riesgos, desastres naturales y emergencias, fortaleciendo la cultura de la protección civil.',
            ],
            [
                'id' => 19,
                'nombre' => 'Salud',
                'descripcion' => 'Fomentar acciones para la promoción de la salud, la prevención de enfermedades y la mejora de los servicios municipales en la materia.',
            ],
            [
                'id' => 20,
                'nombre' => 'Seguridad Pública',
                'descripcion' => 'Coadyuvar en el fortalecimiento de la prevención del delito y la construcción de entornos seguros.',
            ],
            [
                'id' => 21,
                'nombre' => 'Turismo',
                'descripcion' => 'Impulsar estrategias para el fomento del turismo cultural, ecológico y socialmente responsable en el municipio.',
            ],
            [
                'id' => 22,
                'nombre' => 'Vialidad y Transporte',
                'descripcion' => 'Realizar propuestas enfocadas a la mejora del sistema de transporte y la seguridad vial.',
            ],
        ];

        foreach ($consejos as $datos) {
            $consejo = Consejo::findOrNew($datos['id']);

            $consejo->id = $datos['id'];
            $consejo->nombre = $datos['nombre'];
            $consejo->descripcion = $datos['descripcion'];

            $consejo->save();
        }
    }
}
