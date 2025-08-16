import { config } from 'dotenv';

config();

const getEnvVariable = (key: string, defaultValue?: string): string => {
    const value = process.env[key];
    if (!value && defaultValue === undefined) {
        throw new Error(`Missing environment variable: ${key}`);
    }
    return value || defaultValue!;
};

export const PORT = getEnvVariable('PORT', '3000');
export const DB_CONNECTION_STRING = getEnvVariable('DB_CONNECTION_STRING');
export const API_KEY = getEnvVariable('API_KEY');
export const AUTH_SECRET = getEnvVariable('AUTH_SECRET');