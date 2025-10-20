<!-- ========================================
FILE 1: index.jsp (Home Page)
======================================== -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MediCare Hospital - Quality Healthcare Services</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        * { font-family: 'Poppins', sans-serif; }
        .gradient-bg { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .hover-scale { transition: transform 0.3s ease; }
        .hover-scale:hover { transform: scale(1.05); }
        .fade-in { animation: fadeIn 0.5s ease-in; }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="bg-gray-50">

<!-- Navigation -->
<nav class="bg-white shadow-lg fixed w-full top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
            <div class="flex items-center">
                <i class="fas fa-hospital text-purple-600 text-3xl mr-3"></i>
                <span class="text-2xl font-bold text-gray-800">MediCare</span>
            </div>
            <div class="hidden md:flex space-x-8">
                <a href="index.jsp" class="text-purple-600 font-semibold">Home</a>
                <a href="#services" class="text-gray-700 hover:text-purple-600 transition">Services</a>
                <a href="#doctors" class="text-gray-700 hover:text-purple-600 transition">Doctors</a>
                <a href="#about" class="text-gray-700 hover:text-purple-600 transition">About</a>
                <a href="#contact" class="text-gray-700 hover:text-purple-600 transition">Contact</a>
            </div>
            <div class="flex space-x-3">
                <%
                    String username = (String) session.getAttribute("username");
                    if (username != null) {
                %>
                <span class="px-4 py-2 text-purple-600 font-semibold">Welcome, <%= username %></span>
                <a href="logout.jsp" class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition">
                    Logout
                </a>
                <%
                } else {
                %>
                <a href="login.jsp" class="px-4 py-2 text-purple-600 border border-purple-600 rounded-lg hover:bg-purple-50 transition">
                    Login
                </a>
                <a href="register.jsp" class="px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition">
                    Register
                </a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="gradient-bg text-white py-20 mt-16">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid md:grid-cols-2 gap-12 items-center">
            <div class="fade-in">
                <h1 class="text-5xl font-bold mb-6">Your Health, Our Priority</h1>
                <p class="text-xl mb-8 text-gray-100">Providing world-class healthcare services with compassion and excellence. Available 24/7 for your medical needs.</p>
                <div class="flex space-x-4">
                    <button class="bg-white text-purple-600 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition">
                        Book Appointment
                    </button>
                    <button class="border-2 border-white px-8 py-3 rounded-lg font-semibold hover:bg-white hover:text-purple-600 transition">
                        Emergency Care
                    </button>
                </div>
            </div>
            <div class="hidden md:block">
                <div class="bg-white bg-opacity-10 backdrop-blur-lg rounded-2xl p-8 border border-white border-opacity-20">
                    <i class="fas fa-heartbeat text-9xl text-white opacity-50"></i>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Quick Stats -->
<section class="py-12 bg-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
            <div class="hover-scale">
                <div class="text-4xl font-bold text-purple-600">500+</div>
                <div class="text-gray-600 mt-2">Expert Doctors</div>
            </div>
            <div class="hover-scale">
                <div class="text-4xl font-bold text-purple-600">50k+</div>
                <div class="text-gray-600 mt-2">Happy Patients</div>
            </div>
            <div class="hover-scale">
                <div class="text-4xl font-bold text-purple-600">25+</div>
                <div class="text-gray-600 mt-2">Years Experience</div>
            </div>
            <div class="hover-scale">
                <div class="text-4xl font-bold text-purple-600">100+</div>
                <div class="text-gray-600 mt-2">Awards Won</div>
            </div>
        </div>
    </div>
</section>

<!-- Services Section -->
<section id="services" class="py-20 bg-gray-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
            <h2 class="text-4xl font-bold text-gray-800 mb-4">Our Services</h2>
            <p class="text-gray-600 text-lg">Comprehensive healthcare services for all your medical needs</p>
        </div>
        <div class="grid md:grid-cols-3 gap-8">
            <%
                String[][] services = {
                        {"fas fa-user-md", "bg-purple-100", "text-purple-600", "General Medicine", "Comprehensive primary care and preventive health services for all ages."},
                        {"fas fa-heart", "bg-blue-100", "text-blue-600", "Cardiology", "Advanced cardiac care with state-of-the-art diagnostic facilities."},
                        {"fas fa-brain", "bg-green-100", "text-green-600", "Neurology", "Expert neurological care for brain and nervous system disorders."},
                        {"fas fa-ambulance", "bg-red-100", "text-red-600", "Emergency Care", "24/7 emergency services with rapid response medical teams."},
                        {"fas fa-baby", "bg-yellow-100", "text-yellow-600", "Pediatrics", "Specialized healthcare services for infants, children, and adolescents."},
                        {"fas fa-x-ray", "bg-pink-100", "text-pink-600", "Radiology", "Advanced imaging services including MRI, CT scan, and ultrasound."}
                };

                for (String[] service : services) {
            %>
            <div class="bg-white p-8 rounded-xl shadow-lg hover-scale">
                <div class="<%= service[1] %> w-16 h-16 rounded-full flex items-center justify-center mb-6">
                    <i class="<%= service[0] %> <%= service[2] %> text-2xl"></i>
                </div>
                <h3 class="text-2xl font-semibold mb-4"><%= service[3] %></h3>
                <p class="text-gray-600"><%= service[4] %></p>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section id="contact" class="py-20 bg-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
            <h2 class="text-4xl font-bold text-gray-800 mb-4">Get In Touch</h2>
            <p class="text-gray-600 text-lg">We're here to help you 24/7</p>
        </div>
        <div class="grid md:grid-cols-3 gap-8">
            <div class="text-center p-6">
                <div class="bg-purple-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-phone text-purple-600 text-2xl"></i>
                </div>
                <h4 class="font-semibold text-lg mb-2">Phone</h4>
                <p class="text-gray-600">+1 234 567 8900</p>
            </div>
            <div class="text-center p-6">
                <div class="bg-purple-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-envelope text-purple-600 text-2xl"></i>
                </div>
                <h4 class="font-semibold text-lg mb-2">Email</h4>
                <p class="text-gray-600">info@medicare.com</p>
            </div>
            <div class="text-center p-6">
                <div class="bg-purple-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="fas fa-map-marker-alt text-purple-600 text-2xl"></i>
                </div>
                <h4 class="font-semibold text-lg mb-2">Location</h4>
                <p class="text-gray-600">123 Medical Center Dr</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-12">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid md:grid-cols-4 gap-8">
            <div>
                <div class="flex items-center mb-4">
                    <i class="fas fa-hospital text-3xl mr-3"></i>
                    <span class="text-2xl font-bold">MediCare</span>
                </div>
                <p class="text-gray-400">Quality healthcare services you can trust.</p>
            </div>
            <div>
                <h4 class="font-semibold mb-4">Quick Links</h4>
                <ul class="space-y-2 text-gray-400">
                    <li><a href="#" class="hover:text-white transition">About Us</a></li>
                    <li><a href="#services" class="hover:text-white transition">Services</a></li>
                    <li><a href="#doctors" class="hover:text-white transition">Doctors</a></li>
                    <li><a href="#contact" class="hover:text-white transition">Contact</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-semibold mb-4">Services</h4>
                <ul class="space-y-2 text-gray-400">
                    <li><a href="#" class="hover:text-white transition">Emergency Care</a></li>
                    <li><a href="#" class="hover:text-white transition">Cardiology</a></li>
                    <li><a href="#" class="hover:text-white transition">Neurology</a></li>
                    <li><a href="#" class="hover:text-white transition">Pediatrics</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-semibold mb-4">Follow Us</h4>
                <div class="flex space-x-4">
                    <a href="#" class="text-gray-400 hover:text-white transition"><i class="fab fa-facebook text-2xl"></i></a>
                    <a href="#" class="text-gray-400 hover:text-white transition"><i class="fab fa-twitter text-2xl"></i></a>
                    <a href="#" class="text-gray-400 hover:text-white transition"><i class="fab fa-instagram text-2xl"></i></a>
                    <a href="#" class="text-gray-400 hover:text-white transition"><i class="fab fa-linkedin text-2xl"></i></a>
                </div>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
            <p>&copy; 2025 MediCare Hospital. All rights reserved.</p>
        </div>
    </div>
</footer>

</body>
</html>

