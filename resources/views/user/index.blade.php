<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form</title>

    <style>
        body {
            font-family: 'Nunito', sans-serif;
        }

        body input {
            display: block;
        }
    </style>
</head>

<body>

    <label>
        Full Name:
        <input type="text" name="name" />
    </label>
    <label>
        Email:
        <input type="email" name="email" />
    </label>
    <label>
        Phone Number:
        <input type="text" name="phone" />
    </label>
    <label>
        <span>User Role:</span><br>
        Landloard
        <input type="radio" name="role" id="1">
        Tenant
        <input type="radio" name="role" id="1">
        Administrator
        <input type="radio" name="role" id="1">

    </label>
    <label>
        Password:
        <input type="password" name="password" />
    </label>
    <label>
        Confirm Password:
        <input type="password" name="confirm_password" />
    </label>

</body>

</html>
