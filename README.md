# Project Management System

## Overview
A web-based project conversation history management system built with Ruby on Rails that allows users to create projects, track their status and manage project comments with real-time updates.

## Features
- **Project Dashboard** – View and manage all projects in one place.
- **Project Status Management** – Track project progress and updates.
- **Real-time Updates with Turbo Streams** – Seamless live updates without reloading.
- **Project Comments System** – Collaborate with team members using comments.
- **Activity History Tracking** – Keep track of changes and actions performed.
- **Component-based UI Architecture** – Modular and reusable UI components.

## Technology Stack
- **Backend:** Ruby on Rails
- **Template Engine:** Slim
- **Real-time Updates:** Turbo (Hotwire)
- **Testing:** RSpec, Factory Bot
- **Database:** PostgreSQL

## Prerequisites
Before you begin, ensure you have the following installed:
- Ruby 3.x
- Rails 8.x
- PostgreSQL
- Node.js
- Yarn

## Setup and Installation
### 1. Clone the Repository
```bash
git clone [repository-url]
cd [project-directory]
```

### 2. Install Dependencies
```bash
bundle install
yarn install
```

### 3. Database Setup
```bash
rails db:create
rails db:migrate
```

### 4. Start the Rails Server
```bash
rails server
```

Visit [`http://localhost:3000`](http://localhost:3000) to access the application.

## Project Structure
The key components of the application include:
- **Models:** Define the data structure and relationships.
- **Controllers:** Handle business logic and request processing.
- **Views:** Render the user interface using Slim templates.
- **Turbo Streams:** Enable real-time updates.
- **Specs:** RSpec test cases for application stability.
