import axios from 'axios';

class ClaudeClient {
    private apiUrl: string;

    constructor(apiUrl: string) {
        this.apiUrl = apiUrl;
    }

    async executeCode(sessionId: string, code: string): Promise<any> {
        try {
            const response = await axios.post(`${this.apiUrl}/sessions/${sessionId}/execute`, { code });
            return response.data;
        } catch (error) {
            throw new Error(`Error executing code: ${error.message}`);
        }
    }

    async createSession(userId: string): Promise<any> {
        try {
            const response = await axios.post(`${this.apiUrl}/sessions`, { userId });
            return response.data;
        } catch (error) {
            throw new Error(`Error creating session: ${error.message}`);
        }
    }

    async getSession(sessionId: string): Promise<any> {
        try {
            const response = await axios.get(`${this.apiUrl}/sessions/${sessionId}`);
            return response.data;
        } catch (error) {
            throw new Error(`Error fetching session: ${error.message}`);
        }
    }

    async deleteSession(sessionId: string): Promise<void> {
        try {
            await axios.delete(`${this.apiUrl}/sessions/${sessionId}`);
        } catch (error) {
            throw new Error(`Error deleting session: ${error.message}`);
        }
    }
}

export default ClaudeClient;