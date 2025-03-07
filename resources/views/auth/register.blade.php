<!DOCTYPE html>
@extends('layouts.app')

@section('content')
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="{{ asset('css/app.css') }}">
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
    <h2>Sign Up</h2>
    <form action="{{ route('register') }}" method="POST">
        @csrf
        <!-- username-->
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <!-- email-->
        <div class="form-group">
            <label for="email">Email address</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <!--password-->
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <!-- confirm password-->
        <div class="form-group">
            <label for="password_confirmation">Confirm Password</label>
            <input type="password" class="form-control" id="password_confirmation" name="password_confirmation" required>
        </div>
        
        <!-- Allergies-->
        <div class="form-group">
            <label for="allergies">Allergies (Seperate with commas)</label>
            <input type="text" class="form-control" id="allergies" name="allergies" placeholder="eg. , Nuts, Dairy, Gluten">
        </div>

        <!-- cooking skill level-->
        <div class="form-group">
            <label for="cooking_kill">Cooking SKill Level</label>
            <select class="form-control" id="cooking_skill" name="cooking_skill">
                <option value="">Select an option</option>
                <option value="Beginner">Beginner</option>
                <option value="Intermediate">Intermediate</option>
                <option value="Expert">Expert</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Sign Up</button>
    </form>

    </body>
</div>
</html>
@endsection