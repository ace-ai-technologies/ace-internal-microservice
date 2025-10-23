# ACE Internal Microservice

A secure, always-on microservice for internal use by ACE AI Technologies. This service requires authentication and is designed to run on Google Cloud Platform.

## Features

- 🔐 **Authentication Required**: No unauthenticated access
- 🚀 **Always On**: Designed for 24/7 availability
- 🛡️ **Security**: JWT-based authentication, rate limiting, CORS protection
- ☁️ **Cloud-Native**: Built for Google Cloud Run
- 📊 **Health Monitoring**: Built-in health checks and metrics
- 🧪 **Testing**: Comprehensive test suite

## Quick Start

### Prerequisites

- Node.js 18+
- Google Cloud SDK
- Docker (optional)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd ace-microservice
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Start the development server:
```bash
npm run dev
```

### Production Deployment

1. Set up Google Cloud project:
```bash
gcloud config set project your-project-id
```

2. Deploy using the provided script:
```bash
chmod +x deployments/deploy.sh
./deployments/deploy.sh
```

Or manually:
```bash
gcloud builds submit --tag gcr.io/your-project-id/ace-internal-microservice:latest
gcloud run deploy ace-internal-microservice \
    --image gcr.io/your-project-id/ace-internal-microservice:latest \
    --region us-central1 \
    --platform managed \
    --allow-unauthenticated=false
```

## API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `GET /api/auth/validate` - Validate JWT token

### Health Checks
- `GET /api/health` - Basic health check
- `GET /api/health/detailed` - Detailed health metrics

### Protected Routes (require authentication)
- `GET /api/profile` - Get user profile
- `GET /api/internal/data` - Get internal data
- `POST /api/internal/records` - Create internal record

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Server port | 3000 |
| `NODE_ENV` | Environment (development/production) | development |
| `JWT_SECRET` | JWT signing secret | Required |
| `JWT_EXPIRES_IN` | Token expiration time | 24h |
| `ALLOWED_ORIGINS` | Comma-separated list of allowed origins | http://localhost:3000 |
| `RATE_LIMIT_MAX_REQUESTS` | Max requests per window | 100 |
| `RATE_LIMIT_WINDOW_MS` | Rate limit window in milliseconds | 900000 |

## Security Features

- JWT-based authentication
- Password hashing with bcrypt
- Rate limiting
- CORS protection
- Helmet security headers
- Input validation
- Error handling

## Testing

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run linting
npm run lint
```

## Monitoring

The service provides health endpoints for monitoring:
- `/api/health` - Basic health status
- `/api/health/detailed` - System metrics and performance data

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

MIT License - see LICENSE file for details.