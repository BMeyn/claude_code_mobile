import express, { Request, Response } from 'express';
import bodyParser from 'body-parser';
import sessionRoutes from './routes/sessions';
import requireAuth from './middleware/requireAuth';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Health endpoint for readiness/liveness checks
app.get('/health', (_req: Request, res: Response) => {
    res.status(200).json({ status: 'ok' });
});

app.use('/api/sessions', requireAuth, sessionRoutes);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});