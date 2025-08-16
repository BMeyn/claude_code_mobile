import express from 'express';
import bodyParser from 'body-parser';
import sessionRoutes from './routes/sessions';
import { requireAuth } from './middleware/requireAuth';
import { config } from './utils/env';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/api/sessions', requireAuth, sessionRoutes);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});