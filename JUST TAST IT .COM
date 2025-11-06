<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flavorweave</title>
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
        
        /* Increased
