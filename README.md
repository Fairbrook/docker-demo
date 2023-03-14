# Docker 

__Autor:__ Kevin Alan Martínez Virgen

__Clase:__ Computación tolerante a fallas

### Introducción
Docker es una plataforma de contenedores, permite que los equipos trabajen bajo
un mismo ambiente al distribuir "imágenes" que pueden descargar y ejecutar de 
forma local pero que aseguran el mismo ambiente de desarrollo gracias a que 
emulan el sistema operativo y pueden automatizar tareas como movimientos de archivos
e includo compilar el código necesario

### Desarrollo
Para esta práctica, primero desarrollé una aplicación de _Hola mundo_ en express
(plataforma que trabaja con NodeJS) y luego cree el docker file usando com base
una imagen pública de node basado en alpine.

#### Pasos del docker file
- Indica la imagen base
`FROM node:19-alpine`
- Inidca que se está trabajando en un entorno de producción
`ENV NODE_ENV=production`
- Indica el directorio sobre el que se trabajará dentro de la imagen de docker
(en este caso /app)
`WORKDIR /app`
- Copia los archivo sdel proyecto
`COPY . .`
- Instala las dependicias del proyecto de node
`RUN npm install --production`
- Ejecuta el comando para inicializar el servidor
`CMD ["node", "index.js"]`

####  Pasos para construir y ejecutar la imagen
- Compilar la imagen docker
`docker build --tag docker-demo:1.0.0 .`

Y ahora aparece en las imágenes registradas al correr el comando `docker image ls`
```
REPOSITORY                                              TAG         IMAGE ID       CREATED         SIZE
docker-demo                                             1.0.0       c43a0ff4016f   3 minutes ago   182MB
```

- Ahora podemos iniciar una instancia de la imagen
`docker run -d -p 8090:3000 docker-demo:1.0.0`

La opción `-d` es para iniciar en modo _detached_ y la opción `-p 8090:3000`
expone el puerto 3000 del interior de la imagen al puerto local 8090

Ahora podemos observar la instancia ejecutandose mediante el comando `docker ps`
```
CONTAINER ID   IMAGE                                                   COMMAND                  CREATED          STATUS          PORTS                                                                      NAMES
1806ffff150b   docker-demo:1.0.0                                       "docker-entrypoint.s…"   4 seconds ago    Up 3 seconds    0.0.0.0:8090->3000/tcp, :::8090->3000/tcp                                  cranky_wright
6d2203f77705   docker-proxy                                            "/docker-entrypoint.…"   3 hours ago      Up 3 hours      0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp   proxy-dev
```

E incluso podemos hacer una petición al servidor de express
mediante `curl http://localhost:8090/` y obtenemos la respuesta del servidor `Hello world%`
