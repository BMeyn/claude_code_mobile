import express from 'express';
import { SessionsController } from '../controllers/sessionsController';
import { requireAuth } from '../middleware/requireAuth';

const router = express.Router();
const sessionsController = new SessionsController();

// Route to create a new session
router.post('/', requireAuth, sessionsController.createSession);

// Route to get all sessions for the authenticated user
router.get('/', requireAuth, sessionsController.getAllSessions);

// Route to get a specific session by ID
router.get('/:id', requireAuth, sessionsController.getSessionById);

// Route to update a session by ID
router.put('/:id', requireAuth, sessionsController.updateSession);

// Route to delete a session by ID
router.delete('/:id', requireAuth, sessionsController.deleteSession);

export default router;