import { Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import { User } from '../models/User'; // Assuming you have a User model defined
import { getEnv } from '../utils/env';

const JWT_SECRET = getEnv('JWT_SECRET');

class AuthService {
    static async login(req: Request, res: Response) {
        const { username, password } = req.body;

        // Validate user credentials
        const user = await User.findOne({ username });
        if (!user || !(await user.comparePassword(password))) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        // Generate JWT token
        const token = jwt.sign({ id: user._id }, JWT_SECRET, { expiresIn: '1h' });

        return res.status(200).json({ token });
    }

    static async register(req: Request, res: Response) {
        const { username, password } = req.body;

        // Check if user already exists
        const existingUser = await User.findOne({ username });
        if (existingUser) {
            return res.status(409).json({ message: 'User already exists' });
        }

        // Create new user
        const newUser = new User({ username, password });
        await newUser.save();

        return res.status(201).json({ message: 'User registered successfully' });
    }

    static async authenticate(req: Request, res: Response, next: Function) {
        const token = req.headers['authorization']?.split(' ')[1];
        if (!token) {
            return res.status(403).json({ message: 'No token provided' });
        }

        jwt.verify(token, JWT_SECRET, (err: any, decoded: any) => {
            if (err) {
                return res.status(401).json({ message: 'Unauthorized' });
            }
            req.userId = decoded.id;
            next();
        });
    }
}

export default AuthService;