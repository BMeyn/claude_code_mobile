import { Request, Response } from 'express';
import { AuthService } from '../services/auth';
import { ClaudeClient } from '../services/claudeClient';

export class SessionsController {
    private authService: AuthService;
    private claudeClient: ClaudeClient;

    constructor() {
        this.authService = new AuthService();
        this.claudeClient = new ClaudeClient();
    }

    public async createSession(req: Request, res: Response): Promise<void> {
        const { userId, sessionData } = req.body;

        try {
            const session = await this.claudeClient.createSession(userId, sessionData);
            res.status(201).json(session);
        } catch (error) {
            res.status(500).json({ message: 'Error creating session', error });
        }
    }

    public async getSession(req: Request, res: Response): Promise<void> {
        const { sessionId } = req.params;

        try {
            const session = await this.claudeClient.getSession(sessionId);
            if (session) {
                res.status(200).json(session);
            } else {
                res.status(404).json({ message: 'Session not found' });
            }
        } catch (error) {
            res.status(500).json({ message: 'Error retrieving session', error });
        }
    }

    public async deleteSession(req: Request, res: Response): Promise<void> {
        const { sessionId } = req.params;

        try {
            await this.claudeClient.deleteSession(sessionId);
            res.status(204).send();
        } catch (error) {
            res.status(500).json({ message: 'Error deleting session', error });
        }
    }
}