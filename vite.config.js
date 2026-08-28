import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';

const isDocker = process.env.DOCKER_ENV === 'true';

export default defineConfig({
    plugins: [
        laravel({
            input: 'resources/js/app.js',
            refresh: true,
        }),

        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],

    server: {
        host: isDocker ? '0.0.0.0' : 'localhost',
        port: 5173,
        strictPort: true,

        //Autorizar el cors de ambos origenes
        cors: {origin: isDocker
                ? 'http://localhost:8082'
                : 'http://plataformacpc.test',
        },

        ...(isDocker && {
            origin: 'http://localhost:5173',

            hmr: {
                host: 'localhost',
                port: 5173,
            },
        }),
    },
});
