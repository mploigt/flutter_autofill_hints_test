# flutter_autofill_hints_test

Testing of autofillHints parameter

## What's wrong?

Using `autofillHints` in a form messes up the focus behaviour on iOS.

## How to test

- Tap into the username field and tap on the "Next" button in the keyboard.
- Focus jumps to password field and immediately back to username

Also saving the password in iOS keychain is not working