// Health check endpoint - confirms D1 is connected
// URL: /api/health

export async function onRequestGet(context) {
  try {
    const db = context.env.DB;
    if (!db) {
      return Response.json({ status: 'ok', db: 'not configured' });
    }
    const result = await db.prepare('SELECT COUNT(*) as count FROM modules').first();
    return Response.json({
      status: 'ok',
      db: 'connected',
      modules: result.count
    });
  } catch (e) {
    return Response.json({ status: 'ok', db: 'error', message: e.message });
  }
}
