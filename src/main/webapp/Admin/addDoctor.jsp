<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un Docteur - Digital Clinic</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">

<div class="flex h-screen">

    <!-- Sidebar -->
    <aside class="w-64 bg-blue-600 text-white flex flex-col">
        <div class="p-6">
            <h1 class="text-2xl font-bold">Digital Clinic</h1>
        </div>
        <nav class="flex-1 px-4">
            <a href="dashboard.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                <i class="fas fa-home"></i>
                <span>Dashboard</span>
            </a>
            <a href="doctors.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-700 mb-2">
                <i class="fas fa-user-md"></i>
                <span>Doctors</span>
            </a>
            <a href="patients.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                <i class="fas fa-users"></i>
                <span>Patients</span>
            </a>
            <a href="appointments.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                <i class="fas fa-calendar-check"></i>
                <span>Appointments</span>
            </a>
            <a href="reports.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                <i class="fas fa-chart-bar"></i>
                <span>Reports</span>
            </a>
            <a href="settings.jsp" class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-blue-700 transition-colors mb-2">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
            </a>
        </nav>
    </aside>

    <!-- Main Content -->
    <div class="flex-1 flex flex-col overflow-hidden">

        <!-- Header -->
        <header class="bg-white border-b border-gray-200 px-8 py-4">
            <div class="flex items-center justify-between">
                <div class="relative flex-1 max-w-md">
                    <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input type="text" placeholder="Search..."
                           class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                </div>
                <div class="flex items-center gap-4">
                    <button class="relative p-2 text-gray-600 hover:text-gray-900">
                        <i class="fas fa-bell text-xl"></i>
                        <span class="absolute top-0 right-0 w-2 h-2 bg-red-500 rounded-full"></span>
                    </button>
                    <div class="flex items-center gap-3">
                        <img src="/assets/img/admin-avatar.png" alt="Admin" class="w-10 h-10 rounded-full">
                        <div>
                            <p class="text-sm font-medium text-gray-900">Admin</p>
                            <p class="text-xs text-gray-500">Administrator</p>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- Page Content -->
        <main class="flex-1 overflow-y-auto p-8">
            <div class="max-w-4xl mx-auto">
                <div class="mb-6">
                    <h2 class="text-3xl font-bold text-gray-900">Ajouter un Docteur</h2>
                    <p class="text-gray-600 mt-2">Remplissez les informations ci-dessous pour créer un nouveau compte docteur</p>
                </div>

                <!-- Form -->
                <form action="addDoctor" method="post" class="bg-white rounded-lg shadow-sm border border-gray-200 p-8">
                    <input type="hidden" name="action" value="addDoctor">
                    <!-- Informations Personnelles -->
                    <div class="mb-8">
                        <h3 class="text-xl font-semibold text-gray-900 mb-6 pb-3 border-b border-gray-200">
                            <i class="fas fa-user text-blue-600 mr-2"></i>
                            Informations Personnelles
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="nom" class="block text-sm font-medium text-gray-700 mb-2">
                                    Nom Complet <span class="text-red-500">*</span>
                                </label>
                                <input type="text" id="nom" name="nom" required
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       placeholder="Dr. Jean Dupont">
                            </div>
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                                    Email <span class="text-red-500">*</span>
                                </label>
                                <input type="email" id="email" name="email" required
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       placeholder="docteur@example.com">
                            </div>
                            <div>
                                <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                                    Mot de Passe <span class="text-red-500">*</span>
                                </label>
                                <input type="password" id="password" name="password" required
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       placeholder="••••••••">
                            </div>
                            <div>
                                <label for="matricule" class="block text-sm font-medium text-gray-700 mb-2">
                                    Matricule <span class="text-red-500">*</span>
                                </label>
                                <input type="text" id="matricule" name="matricule" required
                                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       placeholder="MAT-2024-001">
                            </div>
                        </div>
                    </div>

                    <!-- Informations Professionnelles -->
                    <div class="mb-8">
                        <h3 class="text-xl font-semibold text-gray-900 mb-6 pb-3 border-b border-gray-200">
                            <i class="fas fa-briefcase text-blue-600 mr-2"></i>
                            Informations Professionnelles
                        </h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="titre" class="block text-sm font-medium text-gray-700 mb-2">
                                    Titre <span class="text-red-500">*</span>
                                </label>
                                <select id="titre" name="titre" required
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="">Sélectionner un titre</option>
                                    <option value="Dr">Dr</option>
                                    <option value="Pr">Pr</option>
                                    <option value="Dr. Spécialiste">Dr. Spécialiste</option>
                                </select>
                            </div>
                            <div>
                                <label for="specialite" class="block text-sm font-medium text-gray-700 mb-2">
                                    Spécialité <span class="text-red-500">*</span>
                                </label>
                                <select id="specialite" name="specialite" required
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="">Sélectionner une spécialité</option>
                                    <option value="S001">S001</option>
                                    <option value="S002">S002</option>
                                    <option value="Pédiatrie">Pédiatrie</option>
                                    <option value="Neurologie">Neurologie</option>
                                    <option value="Orthopédie">Orthopédie</option>
                                    <option value="Gynécologie">Gynécologie</option>
                                    <option value="Médecine Générale">Médecine Générale</option>
                                </select>
                            </div>
                            <div>
                                <label for="role" class="block text-sm font-medium text-gray-700 mb-2">
                                    Rôle <span class="text-red-500">*</span>
                                </label>
                                <select id="role" name="role" required
                                        class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    <option value="">Sélectionner un rôle</option>
                                    <option value="DOCTOR">Docteur</option>
                                    <option value="ADMIN">Administrateur</option>
                                    <option value="PATIENT">Patient</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Statut -->
                    <div class="mb-8">
                        <h3 class="text-xl font-semibold text-gray-900 mb-6 pb-3 border-b border-gray-200">
                            <i class="fas fa-toggle-on text-blue-600 mr-2"></i>
                            Statut
                        </h3>
                        <div class="flex items-center gap-3">
                            <label class="relative inline-flex items-center cursor-pointer">
                                <input type="checkbox" id="actif" name="actif" value="true" checked class="sr-only peer">
                                <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 rounded-full
                                peer peer-checked:after:translate-x-full peer-checked:after:border-white
                                after:content-[''] after:absolute after:top-[2px] after:left-[2px]
                                after:bg-white after:border-gray-300 after:border after:rounded-full
                                after:h-5 after:w-5 after:transition-all peer-checked:bg-blue-600"></div>
                            </label>
                            <label for="actif" class="text-sm font-medium text-gray-700">Compte Actif</label>
                        </div>
                        <p class="text-sm text-gray-500 mt-2">
                            Le docteur pourra se connecter immédiatement si le compte est actif
                        </p>
                    </div>

                    <!-- Buttons -->
                    <div class="flex items-center justify-end gap-4 pt-6 border-t border-gray-200">
                        <a href="${pageContext.request.contextPath}/user/doctors"
                           class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors">
                            Annuler
                        </a>
                        <button type="submit"
                                class="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors flex items-center gap-2">
                            <i class="fas fa-save"></i>
                            Enregistrer le Docteur
                        </button>
                    </div>

                </form>
            </div>
        </main>
    </div>
</div>

</body>
</html>
