-- Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- USERS (clients + coachs via role)
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('USER', 'COACH', 'ADMIN')),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- COACH PROFILES
CREATE TABLE IF NOT EXISTS coaches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    pseudo TEXT NOT NULL,
    description TEXT,
    game TEXT,
    price_per_hour INT NOT NULL DEFAULT 0,
    location TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- TIME SLOTS (disponibilités)
CREATE TABLE IF NOT EXISTS time_slots (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    coach_id UUID NOT NULL REFERENCES coaches(id) ON DELETE CASCADE,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    CHECK (end_time > start_time)
);

-- APPOINTMENTS (réservations)
CREATE TABLE IF NOT EXISTS appointments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    time_slot_id UUID UNIQUE NOT NULL REFERENCES time_slots(id) ON DELETE CASCADE,
    status TEXT NOT NULL CHECK (status IN ('BOOKED', 'CANCELED')),
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Index utiles
CREATE INDEX IF NOT EXISTS idx_coaches_game ON coaches(game);
CREATE INDEX IF NOT EXISTS idx_coaches_location ON coaches(location);
CREATE INDEX IF NOT EXISTS idx_time_slots_coach ON time_slots(coach_id);
CREATE INDEX IF NOT EXISTS idx_time_slots_start ON time_slots(start_time);
