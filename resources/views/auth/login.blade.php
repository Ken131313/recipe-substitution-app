<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Login</title>
</head>

<body>

    @if (session('success'))
        <div class="alert alert-success" role="alert">
            {{ session('success') }}
        </div>
        <script>
            setTimeout(() => {
                window.location.href = "{{ url('/') }}"; // Redirect to home page
            }, 3000); // Redirect after 3 seconds
        </script>
        @endif
    <div class="container">
        @if ($errors->any())
            <div class="alert alert-danger" role="alert">
                    @foreach ($errors->all() as $error)
                    <p>{{ $error }}</p>
                @endforeach
            </div>
        @endif
        <h1>Login</h1>
            <form action="{{ route('login') }}" method="POST">
                @csrf
                <!-- Email -->
                <div class="form-group">
                    <label for="email">Email address</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <!-- Password -->
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary">Log In</button>
            </form>
        </div>
</body>
</html>