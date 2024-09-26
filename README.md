This repo stores my SQL scripts that I created for LeetCode SQL-50 problems.




REGEXP:

WHERE email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';


The ~ operator is case-sensitive, so it will treat uppercase and lowercase letters differently.
If you want a case-insensitive match, you can use the ~* operator in PostgreSQL.
In MySQL, the operator for regular expression matching is REGEXP (or RLIKE)

^[A-Za-z0-9._%+-]+ matches the local part (before the @).
@[A-Za-z0-9.-]+ matches the domain part.
\.[A-Za-z]{2,}$ ensures the domain ends with a valid TLD.

This ^ symbol asserts the start of the string. It ensures that there is no unwanted text before the email.
[A-Za-z0-9._%+-]: This defines the allowed characters in the local part (before the @ symbol).
    A-Za-z: Allows uppercase and lowercase letters.
    0-9: Allows digits.
    ._%+-: Allows special characters that are commonly allowed in email addresses, such as . (dot), _ (underscore), % (percent), + (plus), and - (hyphen).
    +: The + after the character class means "one or more" of these characters. This ensures that the local part has at least one valid character.
    In case of this: ^[A-Za-z][A-Za-z0-9._%+-]*@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$
    (The * means "zero or more" of the preceding characters, meaning the local part after the initial letter can contain zero or more valid characters.)
The @ symbol is the separator between the local part and the domain part of the email address. This is required in every valid email.
[A-Za-z0-9.-]: This defines the allowed characters in the domain part (after the @ symbol).
    A-Za-z: Allows letters (upper and lower case).
    0-9: Allows digits.
    .-: Allows . (dot) and - (hyphen), which are commonly used in domain names. However, neither a . nor - can appear consecutively or at the beginning/end of a valid domain, but this basic regex does not cover that.
+: This ensures that there is at least one or more valid characters in the domain part.
\.: This matches the literal . (dot) before the top-level domain (TLD), like .com or .org.
[A-Za-z]{2,}: This ensures that the top-level domain (like com, org, net) contains at least 2 or more alphabetic characters. TLDs like .co, .us, .info, and .museum are supported with this pattern.
    {2,}: The {2,} ensures a minimum of 2 characters after the dot.
The $ symbol ensures that the string ends right after the top-level domain. This prevents any unwanted trailing characters from being included after the valid email address.

Note that in MySQL, you need to double escape the backslash (\\.) because MySQL needs an extra escape to treat \. as a literal backslash in strings.    
