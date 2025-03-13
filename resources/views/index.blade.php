<!DOCTYPE html>
<html lang="en">

<head>
    
    <meta charset="utf-8">
    <title>Restoran - Bootstrap Restaurant Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <meta name="csrf-token" content="{{ csrf_token() }}"> <!-- Personalised recipes needs -->


    <!-- Favicon -->
    <link rel="icon" href="{{ asset('img/favicon.ico') }}" type="image/x-icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&family=Pacifico&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">


    <!-- Libraries Stylesheet -->
    <link href="{{ asset('lib/animate/animate.min.css') }}" rel="stylesheet">
    <link href="{{ asset('lib/owlcarousel/assets/owl.carousel.min.css') }}" rel="stylesheet">
    <link href="{{ asset('lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css') }}" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="{{ asset('css/bootstrap.min.css') }}" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link rel="stylesheet" href="{{ asset('css/style.css') }}">



    <div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Navbar & Hero Start -->
        <div class="container-xxl position-relative p-0">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4 px-lg-5 py-3 py-lg-0">
                <a href="" class="navbar-brand p-0">
                    <div style="display: flex; align-items: center;">
                        <img src="{{ asset('img/wok.png') }}" alt="Logo" style="height: 50px; margin-right:15px; background-color: transparent;" >
                        <h1 class="text-primary m-0">WOK GUIDE</h1>
                    </div>
                    </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                    <span class="fa fa-bars"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto py-0 pe-4">
                        <a href="{{ route('index') }}" class="nav-item nav-link active">Home</a>
                        <a href="{{ route('about') }}" class="nav-item nav-link">About Us</a>
                        <a href="{{ route('recipes.list') }}" class="nav-item nav-link">View all recipes</a>
                        <a href="service.html" class="nav-item nav-link">Saved recipes</a>
                    </div>
                    <a href="{{ route('register') }}" class="btn btn-primary py-2 px-4">SIGN UP</a>
                    <a href="{{ route('login') }}" class="btn btn-primary py-2 px-4">LOG IN</a>
                </div>
            </nav>
</head>
<body>
            <div class="container-xxl py-5 bg-dark hero-header mb-5">
                <div class="container my-5 py-5">
                    <div class="row align-items-center g-5">
                        <div class="col-lg-6 text-center text-lg-start">
                            <h1 class="display-3 text-white animated slideInLeft">Create Your Own<br>Chinese Meals</h1>
                            <p class="text-white animated slideInLeft mb-4 pb-2">We are WOK Guide! Here to help user to cook chinese meals and get rid of boring meals plan. If you have an idea on chinese meal also, feel free to upload!</p>
                            @auth
                                <a href="{{ route('recipes.creation')}}" class="btn btn-primary py-sm-3 px-sm-5 me-3 animated slideInLeft">
                                    Upload recipe
                                </a>
                            @endauth     
                            @guest
                                <a href="{{ route('login') }}" class="btn btn-secondary py-sm-3 px-sm-5 me-3 animated slideInLeft">
                                    Log in to upload recipes
                                </a>
                            @endguest                   
                        </div>
                        <div class="col-lg-6 text-center text-lg-end overflow-hidden">
                            <img class="img-fluid bounce-animation" src="img/hero.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Navbar & Hero End -->


        <!-- Service Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="d-flex justify-content-center align-items-center flex-wrap">

                        <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.1s">
                            <div class="service-item rounded pt-3">
                                <div class="p-4">
                                    <i class="fa fa-3x fa-user-tie text-primary mb-4"></i>
                                    <h5>Personalise pages</h5>
                                    <p>User with exist account can save their favorite recipes can view their saved recipes at anytime!</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.3s">
                            <div class="service-item rounded pt-3">
                                <div class="p-4">
                                    <i class="fa fa-3x fa-utensils text-primary mb-4"></i>
                                    <h5>Variety of Chinese meals</h5>
                                    <p>Getting bored to cook traditional meals in western style? Try out our chinese meal plans! Let the funs begin!</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6 wow fadeInUp" data-wow-delay="0.5s">
                            <div class="service-item rounded pt-3">
                                <div class="p-4">
                                    <i class="fa fa-3x fa-cart-plus text-primary mb-4"></i>
                                    <h5>Substituions include</h5>
                                    <p>NOT every chinese meal made with meat! Whatever you have allergy or a vegan, we've got your back as well!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Service End -->


        

<br>
            <script src="{{ asset('js/filterRecipes.js') }}"></script>
            <!-- Recommended Recipes Section -->
            <div class="recommended-recipes">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h1 class="mb-5">Recommended for You</h1>
                </div>

                @auth
                <!-- Display User Allergies -->
                @if(auth()->user())
                    <div class="alert alert-info">
                        <strong>We had taken out the food you are allergy with &#128540 :</strong> {{ implode(', ', explode(',', auth()->user()->allergies)) }}
                    </div>
                @endif
                <!-- Recipe List -->
                <div class="row" id="recipeList">
                    @foreach ($recommendedRecipes as $recipe)
                    <div class="col-md-4 recipe-item" data-ingredients="{{ strtolower(implode(', ', is_array($recipe->ingredients) ? $recipe->ingredients : explode(',', $recipe->ingredients))) }}">
                        <div class="card mb-4 shadow-sm">
                            @if (file_exists(public_path($recipe->image)))
                                <img src="{{ asset($recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
                            @elseif (file_exists(storage_path('app/public/' . $recipe->image)))
                                <img src="{{ asset('storage/' . $recipe->image) }}" alt="{{ $recipe->title }}" class="img-fluid rounded">
                            @else
                                <img src="{{ asset('img/default-image.jpg') }}" alt="Image not found" class="img-fluid rounded">
                            @endif

                            <div class="card-body">
                                <h5 class="card-title">
                                    <a href="{{ route('recipes.show', ['slug' => $recipe->slug]) }}" class="text-decoration-none">
                                        {{ $recipe->title }}
                                    </a>
                                </h5>
                                <a href="{{ route('recipes.show', ['slug' => $recipe->slug]) }}" class="btn btn-primary">View Recipe</a>
                            </div>
                        </div>
                    </div>
                    @endforeach
                </div>
                @endauth
                @guest
                    <a href="{{ route('login') }}" class="btn btn-secondary py-sm-3 px-sm-5 me-3 animated slideInLeft">
                        Log in to view YOUR recipes
                    </a>
                @endguest  
            </div>

        

        <!-- Menu Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h1 class="mb-5">Most Popular Recipes</h1>
                </div>
                <div class="tab-class text-center wow fadeInUp" data-wow-delay="0.1s">
                    
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane fade show p-0 active">
                            <div class="row g-4">
                                <!-- First Recipe: Plant-Based Sweet & Sour Stir-fry chicken/tofu -->
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/Plant-Based Sweet & Sour Stir-fry chicken-tofu.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                        <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                    <a href="{{ route('recipes.show', ['slug' => 'plant-based-sweet-sour-stir-fry-chickentofu']) }}" class="text-decoration-none">
                                                        <span>Plant-Based Sweet & Sour Stir-fry chicken/tofu</span>
                                                    </a>
                                        </h5>
                                            <small class="fst-italic">This sweet and sour chicken stir-fry recipe is a version of the Asian-style favorite that includes carrots, bell pepper, garlic, and pineapple. The requisite soy sauce and vinegar add the sour to the sweet!</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/three-cup-chicken.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                        <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <a href="{{ route('recipes.show', ['slug' => 'three-cup-chicken']) }}" class="text-decoration-none">
                                                    <span>Three Cup Chicken</span>
                                                </a>
                                        </h5>
                                            <small class="fst-italic">The name “three cup chicken” refers to a ratio of 1 cup each of soy sauce, rice wine, and sesame oil. Considering that we rarely use sesame oil more than a teaspoon at a time, that is a LOT of sesame oil! </small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/Cantonese-Shrimp-and-Eggs.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <a href="{{ route('recipes.show', ['slug' => 'Cantonese-Shrimp-and-Eggs']) }}" class="text-decoration-none">
                                                    <span>Cantonese Shrimp and Eggs</span>
                                                </a>
                                            </h5>
                                            <small class="fst-italic">Cantonese Shrimp and Eggs is a classic dish that transforms scrambled eggs into an epic dinnertime experience. The trick is the simple addition of a cornstarch slurry, which makes the eggs extra tender and silky!</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/Stuffed-Bitter-Melon.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <a href="{{ route('recipes.show', ['slug' => 'Stuffed-Bitter-Melon']) }}" class="text-decoration-none">

                                                    <span>Stuffed Bitter Melon</span>
                                                </a>
                                            </h5>
                                            <small class="fst-italic">This stuffed bitter melon recipe in black bean sauce is a classic Cantonese dish that highlights a produce item in abundance right now in Chinese groceries and backyard gardens: bitter melon! </small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/Kung-Pao-Shrimp.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <a href="{{ route('recipes.show', ['slug' => 'Kung-Pao-Shrimp']) }}" class="text-decoration-none">

                                                    <span>Kung Pao Shrimp</span>
                                                </a>
                                            </h5>
                                            <small class="fst-italic">This Kung Pao Shrimp is a symphony of flavors, accentuated by the crunch of peanuts and the spice of Sichuan peppercorns and dried red chilies. It’s delicious with rice, and disappeared fast when we cooked and photographed it! A telltale sign of a winning recipe. </small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/Bok-Choy-Stir-fry.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <a href="{{ route('recipes.show', ['slug' => 'Bok-Choy-Stir-fry']) }}" class="text-decoration-none">

                                                    <span>Bok Choy Stir-fry</span>
                                                 </a>
                                            </h5>
                                            <small class="fst-italic">We all need a go-to green vegetable side dish to go with any main course, and this bok choy stir-fry recipe is a great candidate.</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/Tomato-Potato-Soup.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <a href="{{ route('recipes.show', ['slug' => 'Tomato-Potato-Soup']) }}" class="text-decoration-none">

                                                    <span>Tomato Potato Soup</span>
                                                </a>
                                            </h5>
                                            <small class="fst-italic">This simple tomato potato soup is a summer staple, with just 5 ingredients (plus water). It’s a light snack or side dish that replenishes your body with fluids and salt on those sweat-inducing hot days! </small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/Coconut-Curry-Shrimp.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <a href="{{ route('recipes.show', ['slug' => 'Coconut-Curry-Shrimp']) }}" class="text-decoration-none">

                                                    <span>Coconut Curry Shrimp</span>
                                                </a>
                                            </h5>
                                            <small class="fst-italic">This simple coconut curry shrimp in a delicious red curry sauce will have you enjoying a restaurant experience at home on any day of the week. With just 9 ingredients (and 2 optional ones) and 30 minutes of time in the kitchen, cooking dinner might be easier—and certainly cheaper—than going out or ordering takeout! </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>       
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Menu End -->


        <!-- Testimonial Start -->
        <div class="container-xxl py-5 wow fadeInUp" data-wow-delay="0.1s">
            <div class="container">
                <div class="text-center">
                    <h5 class="section-title ff-secondary text-center text-primary fw-normal">Testimonials</h5>
                    <h1 class="mb-5">What Our Clients Say</h1>
                </div>
                <div class="owl-carousel testimonial-carousel">
                    <div class="testimonial-item bg-transparent border rounded p-4">
                        <i class="fa fa-quote-left fa-2x text-primary mb-3"></i>
                        <p>The recipes are well-structured and easy to follow. I love how clear the instructions are!</p>
                        <div class="d-flex align-items-center">
                            <img class="img-fluid flex-shrink-0 rounded-circle" src="img/testimonial-1.jpg" style="width: 50px; height: 50px;">
                            <div class="ps-3">
                                <h5 class="mb-1">Emily Johnson</h5>
                                <small>Home Cook</small>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-item bg-transparent border rounded p-4">
                        <i class="fa fa-quote-left fa-2x text-primary mb-3"></i>
                        <p>This website provides great recipes that suit my dietary needs. Highly recommended for personalized cooking!</p>
                        <div class="d-flex align-items-center">
                            <img class="img-fluid flex-shrink-0 rounded-circle" src="img/testimonial-2.jpg" style="width: 50px; height: 50px;">
                            <div class="ps-3">
                                <h5 class="mb-1">James Carter</h5>
                                <small>Nutritionist</small>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-item bg-transparent border rounded p-4">
                        <i class="fa fa-quote-left fa-2x text-primary mb-3"></i>
                        <p>I appreciate the ingredient substitution feature—it helped me find alternatives for my allergies easily!</p>
                        <div class="d-flex align-items-center">
                            <img class="img-fluid flex-shrink-0 rounded-circle" src="img/testimonial-3.jpg" style="width: 50px; height: 50px;">
                            <div class="ps-3">
                                <h5 class="mb-1">Sophia Lee</h5>
                                <small>Food Enthusiast</small>
                            </div>
                        </div>
                    </div>
                    <div class="testimonial-item bg-transparent border rounded p-4">
                        <i class="fa fa-quote-left fa-2x text-primary mb-3"></i>
                        <p>The variety of recipes and personalized suggestions make cooking so much more enjoyable for me!</p>
                        <div class="d-flex align-items-center">
                            <img class="img-fluid flex-shrink-0 rounded-circle" src="img/testimonial-4.jpg" style="width: 50px; height: 50px;">
                            <div class="ps-3">
                                <h5 class="mb-1">Daniel Thompson</h5>
                                <small>Chef</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Testimonial End -->

        

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-light footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Company</h4>
                        <a href="{{ route('about') }}" class="nav-link">About Us</a>
                        

 
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h4 class="section-title ff-secondary text-start text-primary fw-normal mb-4">Contact</h4>
                        
                        <p class="mb-2"><i class="fa fa-envelope me-3"></i>ken@example.com</p>
                        
                    </div>
                    
                    
                </div>
            </div>
            <div class="container">
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            &copy; <a class="border-bottom" href="#">WOK GUIDE</a>, All Right Reserved. 
							
							<!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
							Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a><br><br>
                            Distributed By <a class="border-bottom" href="https://themewagon.com" target="_blank">ThemeWagon</a>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>
    
    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="{{ asset('lib/wow/wow.min.js') }}"></script>
    <script src="{{ asset('lib/easing/easing.min.js') }}"></script>
    <script src="{{ asset('lib/waypoints/waypoints.min.js') }}"></script>
    <script src="{{ asset('lib/counterup/counterup.min.js') }}"></script>
    <script src="{{ asset('lib/owlcarousel/owl.carousel.min.js') }}"></script>
    <script src="{{ asset('lib/tempusdominus/js/moment.min.js') }}"></script>
    <script src="{{ asset('lib/tempusdominus/js/moment-timezone.min.js') }}"></script>
    <script src="{{ asset('lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js') }}"></script>


    <!-- Template Javascript -->
    <script src="{{ asset('js/main.js') }}"></script>



</body>

</html>