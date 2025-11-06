<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JUST.TAST.IT</title>
    <!-- Load Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        /* Base font size increased for better readability */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0fdf4; /* Light Green/Mint Background */
            font-size: 1.125rem; /* Base text-lg equivalent */
        }
        
        /* Ensure all text is dark for high contrast */
        .text-default {
            color: #1f2937; /* Gray 800 */
        }

        /* Card hover effect */
        .recipe-card {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .recipe-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgba(16, 185, 129, 0.3), 0 4px 6px -2px rgba(16, 185, 129, 0.2);
        }
        
        /* Custom spinner for better aesthetics (Mint/Green theme) */
        .spinner {
            border-top-color: #10b981; /* Emerald 500 */
            border-left-color: #34d399; /* Emerald 400 */
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .message-box {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 3000; 
        }
        /* Modal styling */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1000;
            display: none; 
            overflow-y: auto;
            padding: 20px 0;
            
            /* Styles for dynamic background image */
            background-color: rgba(0, 0, 0, 0.7); 
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            transition: background-image 0.5s;
            backdrop-filter: blur(8px); 
        }
        .modal-content {
            background: white;
            margin: 20px auto;
            max-width: 95%;
            width: 800px; 
            border-radius: 1.5rem; 
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.8);
            position: relative;
        }
        
        /* Increased padding and focus state for controls */
        .form-control {
            padding: 0.75rem 1rem; 
            border-width: 2px;
        }
        .form-control:focus {
             outline: none;
             box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.5); 
        }
        .instruction-step p {
             line-height: 1.8; 
        }
    </style>
</head>
<body class="min-h-screen text-default flex flex-col">

    <!-- Header -->
    <header class="bg-emerald-700 shadow-xl sticky top-0 z-20">
        <div class="max-w-6xl mx-auto p-5 flex flex-col sm:flex-row justify-between items-center space-y-3 sm:space-y-0">
            <!-- FINAL APP TITLE -->
            <h1 class="text-4xl font-extrabold text-white">Flavorweave</h1>
            
            <!-- REFRESH BUTTON -->
            <button id="refreshButton" class="bg-emerald-400 hover:bg-emerald-500 text-white font-bold text-xl p-3 rounded-full transition duration-150 shadow-lg w-12 h-12 flex items-center justify-center" title="Refresh Recipes">
                <!-- Refresh Icon SVG -->
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                </svg>
            </button>
        </div>
    </header>

    <!-- Main Content Container (Zoomed Out to max-w-6xl) -->
    <main class="flex-grow max-w-6xl mx-auto p-4 sm:p-6 mt-6">
        
        <!-- Controls: Search and Category -->
        <div class="space-y-6 mb-8">
            <!-- Search Bar -->
            <div class="flex items-center p-2 bg-white rounded-2xl shadow-xl border-2 border-emerald-400">
                <input type="text" id="searchQuery" placeholder="Search by name or ingredient (e.g., 'Chicken Curry' or 'Bobotie')"
                       class="form-control flex-grow border-none focus:ring-0 text-xl font-medium" />
                <button id="searchButton" class="bg-emerald-600 hover:bg-emerald-700 text-white font-bold py-3 px-6 rounded-xl transition duration-150">
                    Search
                </button>
            </div>

            <!-- Category Selector -->
            <div class="flex flex-col sm:flex-row justify-between items-center p-6 bg-white rounded-2xl shadow-xl space-y-4 sm:space-y-0">
                <label for="categorySelect" class="text-xl font-bold text-gray-700">Filter:</label>
                <select id="categorySelect" class="form-control block w-full sm:w-1/2 border-emerald-400 rounded-xl focus:border-emerald-600 transition duration-150">
                    <!-- Options will be populated by JavaScript -->
                </select>
            </div>
        </div>


        <div id="statusMessage" class="text-center p-10 bg-white rounded-2xl shadow-xl transition duration-300 hidden">
            <!-- Used for welcome, loading, and error messages -->
        </div>

        <!-- Recipe Grid -->
        <div id="recipeGrid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <!-- Recipes will be injected here by JavaScript -->
        </div>
    </main>
    
    <!-- Footer for Credit -->
    <footer class="mt-8 py-4 text-center">
        <p class="text-sm text-gray-500">Created by Zyler Ram</p>
    </footer>

    <!-- Recipe Detail Modal Overlay -->
    <div id="recipeModal" class="modal-overlay">
        <div id="modalContent" class="modal-content">
            <!-- Detail content or loading spinner will be inserted here -->
        </div>
    </div>

    <!-- Custom Message Box for Interaction Feedback -->
    <div id="messageBox" class="message-box p-4 bg-gray-900 text-white text-lg rounded-xl shadow-2xl opacity-0 transition-opacity duration-300 pointer-events-none">
    </div>

    <script>
        // DOM Elements
        const recipeGrid = document.getElementById('recipeGrid');
        const statusMessage = document.getElementById('statusMessage');
        const refreshButton = document.getElementById('refreshButton');
        const categorySelect = document.getElementById('categorySelect');
        const messageBox = document.getElementById('messageBox');
        const recipeModal = document.getElementById('recipeModal');
        const modalContent = document.getElementById('modalContent');
        const searchButton = document.getElementById('searchButton');
        const searchQueryInput = document.getElementById('searchQuery');

        // API Configuration (TheMealDB)
        const BASE_API_CATEGORY_URL = 'https://www.themealdb.com/api/json/v1/1/filter.php?c='; 
        const BASE_API_AREA_URL = 'https://www.themealdb.com/api/json/v1/1/filter.php?a=';
        const BASE_API_SEARCH_NAME_URL = 'https://www.themealdb.com/api/json/v1/1/search.php?s='; 
        const BASE_API_DETAIL_URL = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=';
        const BASE_API_RANDOM_URL = 'https://www.themealdb.com/api/json/v1/1/randomselection.php';

        // REFACTORED CATEGORY LIST 
        // filterType: 'a' = Area, 'c' = Category, 'r' = Random
        const CATEGORIES = [
            { label: '--- Recommended Cuisines ---', type: 'header' },
            { label: 'Indian (Default)', apiValue: 'Indian', filterType: 'a' },
            { label: 'South African (Lamb)', apiValue: 'Lamb', filterType: 'c' }, 
            { label: '--- Global Cuisines ---', type: 'header' },
            { label: 'Mexican', apiValue: 'Mexican', filterType: 'a' },
            { label: 'Italian', apiValue: 'Italian', filterType: 'a' },
            { label: 'Japanese', apiValue: 'Japanese', filterType: 'a' },
            { label: 'Thai', apiValue: 'Thai', filterType: 'a' },
            { label: 'Chinese', apiValue: 'Chinese', filterType: 'a' },
            { label: 'French', apiValue: 'French', filterType: 'a' },
            { label: 'American', apiValue: 'American', filterType: 'a' },
            { label: 'British', apiValue: 'British', filterType: 'a' },
            { label: '--- Dish Type Filters ---', type: 'header' },
            { label: 'Random Mix (Any Dish)', apiValue: 'Random', filterType: 'r' },
            { label: 'Dessert', apiValue: 'Dessert', filterType: 'c' },
            { label: 'Chicken', apiValue: 'Chicken', filterType: 'c' }, 
            { label: 'Beef', apiValue: 'Beef', filterType: 'c' },
            { label: 'Seafood', apiValue: 'Seafood', filterType: 'c' },
            { label: 'Vegetarian', apiValue: 'Vegetarian', filterType: 'c' },   
        ];
        
        // --- UI & Utility Functions ---

        /**
         * Utility function to show a temporary message.
         */
        function showTempMessage(message) {
            messageBox.textContent = message;
            messageBox.classList.remove('opacity-0');
            messageBox.classList.add('opacity-100');
            clearTimeout(messageBox.timer);
            messageBox.timer = setTimeout(() => {
                messageBox.classList.remove('opacity-100');
                messageBox.classList.add('opacity-0');
            }, 2500);
        }

        /**
         * Populates the category dropdown with options from the CATEGORIES list.
         */
        function populateCategories() {
            let html = '';
            let currentOptGroup = null;

            CATEGORIES.forEach(cat => {
                if (cat.type === 'header') {
                    // Close previous optgroup if it exists
                    if (currentOptGroup) {
                        html += '</optgroup>';
                    }
                    // Start new optgroup
                    html += `<optgroup label="${cat.label}">`;
                    currentOptGroup = cat.label;
                } else {
                    html += `
                        <option 
                            value="${cat.apiValue}" 
                            data-filter-type="${cat.filterType}">
                            ${cat.label}
                        </option>
                    `;
                }
            });

            // Close the final optgroup
            if (currentOptGroup) {
                html += '</optgroup>';
            }

            categorySelect.innerHTML = html;
            categorySelect.value = 'Indian'; // Set default to Indian cuisine
        }

        /**
         * Shows the main status message (welcome/loading/error)
         */
        function showStatus(htmlContent, bgColor = 'bg-white') {
            recipeGrid.innerHTML = '';
            statusMessage.classList.remove('hidden', 'bg-red-100', 'bg-white');
            statusMessage.classList.add(bgColor);
            statusMessage.innerHTML = htmlContent;
        }

        /**
         * Enables/Disables all main interaction controls.
         */
        function toggleControls(disabled) {
            refreshButton.disabled = disabled;
            categorySelect.disabled = disabled;
            searchButton.disabled = disabled;
            searchQueryInput.disabled = disabled;
            if (disabled) {
                refreshButton.classList.add('opacity-50', 'pointer-events-none');
                searchButton.classList.add('opacity-50', 'pointer-events-none');
            } else {
                refreshButton.classList.remove('opacity-50', 'pointer-events-none');
                searchButton.classList.remove('opacity-50', 'pointer-events-none');
            }
        }

        /**
         * Renders the main loading spinner.
         */
        function showLoading(message) {
            const loadingHtml = `
                <div class="flex flex-col items-center space-y-4">
                    <div class="spinner w-16 h-16 border-4 border-gray-200 rounded-full mb-6"></div>
                    <p class="text-2xl font-bold text-emerald-600">${message}</p>
                </div>
            `;
            showStatus(loadingHtml);
            toggleControls(true);
        }

        /**
         * Hides the status message and enables interaction.
         */
        function hideStatus() {
            statusMessage.classList.add('hidden');
            toggleControls(false);
        }

        /**
         * Renders the main error message AND ensures controls are re-enabled.
         */
        function showError(message) {
            console.error('Application Error:', message); // Log error for debugging
            const errorHtml = `
                <div class="flex flex-col items-center space-y-4 text-red-800">
                    <svg class="w-16 h-16" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path></svg>
                    <p class="text-2xl font-extrabold">Oops! An issue occurred.</p>
                    <p class="text-lg">Could not load recipes. ${message}. Please check your connection or try a different filter.</p>
                </div>
            `;
            showStatus(errorHtml, 'bg-red-100');
            toggleControls(false); 
        }
        
        /**
         * Displays the welcome message and then initiates the first recipe fetch.
         */
        function displayWelcomeAndFetch() {
            // 1. Display the welcome message briefly
            const welcomeHtml = `
                <div class="text-center p-10 bg-white rounded-2xl shadow-xl space-y-4">
                    <p class="text-4xl font-extrabold text-emerald-700">Welcome to Flavorweave!</p>
                    <p class="text-xl text-gray-700 max-w-2xl mx-auto">
                        Your key to **culinary discovery**. Use the search bar above to find specific recipes by name or ingredient, 
                        or use the filter to explore global cuisines and dish types. Get ready to weave your next great meal!
                    </p>
                    <p class="text-lg text-gray-500">Loading default recipes now...</p>
                </div>
            `;
            showStatus(welcomeHtml);
            toggleControls(true); // Disable while the initial fetch happens (prevents rapid clicking)

            // 2. Start fetching default recipes after a short delay for visibility
            setTimeout(() => {
                fetchRecipes(false); // Fetch default 'Indian' cuisine
            }, 2000); 
        }


        // --- Recipe List Functions (Load & Search) ---

        /**
         * Creates the HTML for a single recipe card.
         */
        function createRecipeCard(meal, tag) {
            const title = meal.strMeal || 'Unknown Meal';
            const imageUrl = meal.strMealThumb || 'https://placehold.co/400x300/10b981/ffffff?text=Image+Unavailable';
            
            const tagText = tag || meal.strArea || 'Meal';
            
            return `
                <div class="recipe-card bg-white rounded-2xl shadow-xl overflow-hidden cursor-pointer border-t-8 border-emerald-600"
                     data-id-meal="${meal.idMeal}"
                     data-title="${title.replace(/"/g, '')}"
                     onclick="handleCardClick(this)">
                    
                    <!-- Image -->
                    <img src="${imageUrl}" 
                         alt="${title}" 
                         class="w-full h-56 object-cover object-center"
                         onerror="this.onerror=null; this.src='https://placehold.co/400x300/10b981/ffffff?text=Image+Unavailable';"
                    >
                    
                    <!-- Content -->
                    <div class="p-5">
                        <h2 class="text-xl font-bold text-gray-800 mb-3 truncate">${title}</h2>
                        <span class="inline-block bg-emerald-100 text-emerald-800 text-base font-semibold px-4 py-1 rounded-full border border-emerald-300">${tagText}</span>
                    </div>
                </div>
            `;
        }

        /**
         * Main function to fetch the list of recipes based on search or filter.
         */
        async function fetchRecipes(isSearch = false) {
            let apiEndpoint = '';
            let tag = '';
            
            // 1. Determine the source (Search vs. Category Filter)
            if (isSearch && searchQueryInput.value.trim() !== '') {
                const query = searchQueryInput.value.trim();
                apiEndpoint = BASE_API_SEARCH_NAME_URL + query;
                tag = 'Search: ' + query;
            } else {
                // Category Filter Logic (uses the improved selector attributes)
                const selectedOption = categorySelect.options[categorySelect.selectedIndex];
                const apiValue = selectedOption.value;
                const filterType = selectedOption.getAttribute('data-filter-type');
                tag = selectedOption.textContent.trim(); // Use the full display label

                if (filterType === 'r') {
                    apiEndpoint = BASE_API_RANDOM_URL;
                } else if (filterType === 'c') {
                    apiEndpoint = BASE_API_CATEGORY_URL + apiValue;
                } else if (filterType === 'a') {
                    apiEndpoint = BASE_API_AREA_URL + apiValue;
                }
            }
            
            showLoading(`Loading recipes for: ${tag}`);
            
            try {
                const response = await fetch(apiEndpoint);
                
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                
                const data = await response.json();
                const meals = data.meals || []; 

                if (meals.length === 0) {
                    showStatus(`<p class="text-2xl font-bold text-gray-600">Sorry, no recipes found for "${tag}". Try searching or selecting a different filter.</p>`);
                    toggleControls(false); 
                    return;
                }

                recipeGrid.innerHTML = meals.map(meal => createRecipeCard(meal, tag)).join('');
                hideStatus();

            } catch (error) {
                showError(error.message || 'The network request failed.');
            }
        }

        // --- Recipe Detail Functions (Modal) ---

        function showModalLoading(title) {
            recipeModal.style.display = 'flex';
            recipeModal.style.backgroundImage = '';
            
            modalContent.innerHTML = `
                <div class="p-10 flex flex-col items-center justify-center h-80">
                    <div class="spinner w-16 h-16 border-4 border-gray-200 rounded-full mb-6"></div>
                    <p class="text-2xl font-bold text-white">Loading details for ${title}...</p>
                </div>
            `;
        }

        function hideModal() {
            recipeModal.style.display = 'none';
            modalContent.innerHTML = '';
            recipeModal.style.backgroundImage = '';
        }

        function extractIngredients(meal) {
            const ingredients = [];
            for (let i = 1; i <= 20; i++) {
                const ingredient = meal[`strIngredient${i}`];
                const measure = meal[`strMeasure${i}`];
                
                if (ingredient && ingredient.trim() && measure && measure.trim()) {
                    ingredients.push({ 
                        ingredient: ingredient.trim(), 
                        measure: measure.trim() 
                    });
                }
            }
            return ingredients;
        }

        function renderModalContent(meal) {
            const ingredientsList = extractIngredients(meal);
            // Robustly split instructions, handling potential null or empty strings
            const instructions = meal.strInstructions ? 
                meal.strInstructions.split('.').filter(p => p.trim() !== '') : 
                ['No detailed instructions provided by the source for this recipe.'];
            
            const categoryTag = meal.strCategory ? `<span class="inline-block bg-emerald-100 text-emerald-800 text-lg font-semibold px-4 py-1 rounded-full border border-emerald-300">${meal.strCategory}</span>` : '';
            const areaTag = meal.strArea ? `<span class="inline-block bg-gray-100 text-gray-700 text-lg font-semibold px-4 py-1 rounded-full ml-3 border border-gray-300">${meal.strArea}</span>` : '';

            const ingredientHtml = ingredientsList.map(item => 
                `<li class="flex justify-between items-start py-3 border-b border-gray-300 last:border-b-0">
                    <span class="text-gray-700 text-xl font-medium">${item.ingredient}</span>
                    <span class="font-bold text-right text-emerald-600 text-xl">${item.measure}</span>
                </li>`
            ).join('');

            const instructionsHtml = instructions.map((step, index) => {
                 const stepText = step.trim().endsWith('.') ? step.trim() : step.trim() + '.';
                 return `
                    <div class="mb-6 instruction-step">
                        <p class="font-extrabold text-2xl text-emerald-700 mb-2">STEP ${index + 1}</p>
                        <p class="text-black text-xl leading-relaxed">${stepText}</p> 
                    </div>
                 `;
            }).join('');

            modalContent.innerHTML = `
                <div class="p-8 relative">
                    <!-- Close Button -->
                    <button onclick="hideModal()" class="absolute top-6 right-6 text-gray-500 hover:text-gray-800 transition p-2 rounded-full bg-white shadow-lg z-50">
                        <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M6 18L18 6M6 6l12 12"></path></svg>
                    </button>

                    <!-- Header -->
                    <div class="text-center pb-6 border-b-4 border-emerald-200 mb-6">
                        <h2 class="text-4xl font-black text-gray-800 mb-3">${meal.strMeal}</h2>
                        <div class="flex justify-center">${categoryTag} ${areaTag}</div>
                    </div>

                    <!-- Main Recipe Body -->
                    <div class="py-4 grid grid-cols-1 lg:grid-cols-2 gap-10">
                        
                        <div class="lg:col-span-1">
                            <img src="${meal.strMealThumb}" 
                                 alt="${meal.strMeal}" 
                                 class="w-full h-auto object-cover rounded-2xl shadow-xl mb-6"
                                 onerror="this.onerror=null; this.src='https://placehold.co/400x300/10b981/ffffff?text=Image+Unavailable';"
                            >
                            <h3 class="text-3xl font-extrabold text-emerald-700 border-b-2 border-emerald-500 pb-2 mb-4">Recipe Source</h3>
                            <p class="text-gray-800 text-xl">
                                ${meal.strSource ? `<a href="${meal.strSource}" target="_blank" class="text-blue-600 hover:text-blue-800 font-semibold underline transition">View Full Original Source</a>` : 'Source Not Provided'}
                            </p>
                        </div>
                        
                        <div class="lg:col-span-1">
                            <h3 class="text-3xl font-extrabold text-emerald-700 border-b-2 border-emerald-500 pb-2 mb-4">Ingredients & Measures</h3>
                            <div class="p-6 bg-gray-100 rounded-xl shadow-inner max-h-[500px] overflow-y-auto">
                                <ul class="list-none p-0">
                                    ${ingredientHtml.length > 0 ? ingredientHtml : '<li class="text-gray-500 text-xl py-3">No detailed ingredients found.</li>'}
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Instructions -->
                    <div class="mt-4 pt-8">
                        <h3 class="text-3xl font-extrabold text-emerald-700 border-b-2 border-emerald-500 pb-2 mb-6">Instructions</h3>
                        
                        <div class="space-y-4 p-6 bg-gray-100 rounded-xl shadow-inner">
                            ${instructionsHtml}
                        </div>
                    </div>
                </div>
            `;
        }

        async function fetchMealDetails(mealId, title) {
            showModalLoading(title);

            try {
                const response = await fetch(BASE_API_DETAIL_URL + mealId);
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const data = await response.json();
                const meal = data.meals ? data.meals[0] : null;

                if (!meal) {
                    modalContent.innerHTML = `<div class="p-10 text-center text-red-700 text-2xl font-bold">Details not found for meal ID: ${mealId}.</div>`;
                    return;
                }
                
                const backgroundImageUrl = meal.strMealThumb || '';
                if (backgroundImageUrl) {
                    recipeModal.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.85)), url(${backgroundImageUrl})`;
                }

                renderModalContent(meal);

            } catch (error) {
                console.error('API Detail Fetch Error:', error);
                modalContent.innerHTML = `<div class="p-10 text-center text-red-700 text-2xl font-bold">Error fetching details: ${error.message}.</div>`;
            }
        }

        function handleCardClick(element) {
            const mealId = element.getAttribute('data-id-meal');
            const title = element.getAttribute('data-title');
            
            if (mealId) {
                showTempMessage(`Fetching details for: ${title}`);
                fetchMealDetails(mealId, title);
            } else {
                showTempMessage(`Could not find ID for ${title}.`);
            }
        }

        // --- Event Listeners and Initialization ---
        
        populateCategories();

        // New initialization sequence: Display welcome, then fetch recipes
        window.onload = displayWelcomeAndFetch; 

        refreshButton.addEventListener('click', () => {
            searchQueryInput.value = ''; 
            fetchRecipes(false);
        });
        
        categorySelect.addEventListener('change', () => {
             searchQueryInput.value = ''; 
             fetchRecipes(false);
        });
        
        searchButton.addEventListener('click', () => {
            if (searchQueryInput.value.trim() !== '') {
                // Set the filter to an arbitrary non-default value to visually indicate search is active
                categorySelect.value = 'Dessert'; 
                fetchRecipes(true);
            } else {
                showTempMessage('Please enter a search term (name or ingredient).');
            }
        });
        
        searchQueryInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                searchButton.click();
            }
        });
        
        recipeModal.addEventListener('click', function(event) {
            if (event.target === recipeModal) {
                hideModal();
            }
        });

    </script>
</body>
</html>

