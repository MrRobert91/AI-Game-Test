# Imagen de producción: sirve el juego (un único index.html) con nginx.
FROM nginx:1.27-alpine

# Puerto de escucha. Sliplane lo detecta vía EXPOSE; se puede cambiar con la variable PORT.
ENV PORT=8080

# La imagen oficial de nginx procesa /etc/nginx/templates/*.template con envsubst al arrancar.
RUN rm -f /etc/nginx/conf.d/default.conf
COPY docker/default.conf.template /etc/nginx/templates/default.conf.template
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q -O /dev/null "http://127.0.0.1:${PORT}/healthz" || exit 1
