# PHP7.4

Versión con xdebug o sin xdebug

Para que xdebug funcione el docker-compose en el que se incluya el servicio
ha de añadir estas líneas:

```
        extra_hosts:
            - "host.docker.internal:host-gateway"
```

Si se quiere configurar xdebug habría que modificar el archivo
/etc/php/7.4/apache2/conf.d/docker-php-ext-xdebug.ini montandolo
externamente

La configuración está hecha para conectar con el servidor host
en el puerto 9003