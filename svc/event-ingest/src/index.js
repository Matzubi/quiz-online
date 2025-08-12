import Fastify from 'fastify';
const app = Fastify();
app.get('/healthz', async () => ({ ok: true }));
app.listen({ port: 7070, host: '0.0.0.0' });
