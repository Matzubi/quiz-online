import Fastify from 'fastify';
const app = Fastify();
app.get('/healthz', async () => ({ ok: true }));
app.listen({ port: 8080, host: '0.0.0.0' });
