-- Write the following SQL statements in `joins.sql`

-- 1. Create a query to get all fields from the `users` table
-- 111ms(+190ms) 50000rows
-- 75ms(+72ms) 50000rows
SELECT * FROM users;

-- 1. Create a query to get all fields from the `posts` table where the `user_id` is 100
-- 10ms 1row
-- 11ms 1row
SELECT * FROM posts WHERE user_id = 100;

-- 1. Create a query to get all posts fields, the user's first name, and the user's last name, from the `posts` table where the user's id is 200
-- inner join returns only entries that match in both tables, a left join takes all the entries from first table and any that match in the second table. A right join is the reverse of a left join (ie: all from the second table)
-- SELECT 1st table.column_name, 2nd table.column_name
-- FROM 1st table
-- LEFT JOIN 2nd table ON 1st table.FK = 2nd table.column_name
-- WHERE 2nd table.column_name = 200;
-- 13ms 1row
SELECT posts.*, users.first_name, users.last_name
FROM posts
LEFT JOIN users ON posts.user_id = users.id
WHERE users.id = 200;

-- 1. Create a query to get all posts fields, and the user's username, from the `posts` table where the user's first name is 'Norene' and the user's last_name is 'Schmitt'
-- 16ms 1row
SELECT posts.*, users.username
FROM posts
LEFT JOIN users ON posts.user_id = users.id
WHERE users.first_name = 'Norene' AND users.last_name = 'Schmitt';

-- 1. Create a query to get usernames from the `users` table where the user has created a post after January 1, 2015
-- 47ms(+3ms) 26598rows
SELECT username
FROM users
LEFT JOIN posts ON users.id = posts.user_id
WHERE posts.created_at > '2015-01-01';

-- 1. Create a query to get the post title, post content, and user's username where the user who created the post joined before January 1, 2015
SELECT posts.title, posts.content, users.username
-- 68ms(+19ms) 23488rows
FROM posts
LEFT JOIN users ON posts.user_id = users.id
-- 68ms(+21ms) 32158rows
FROM users
LEFT JOIN posts ON users.id = posts.user_id
-- 69ms(+19ms) 32158rows
FROM posts
RIGHT JOIN users ON posts.user_id = users.id
-- 65ms(+13ms) 23488rows
FROM users
RIGHT JOIN posts ON users.id = posts.user_id
WHERE users.created_at < '2015-01-01';

-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as 'Post Title'), and the all the comment's fields

SELECT comments.*, posts.title AS "Post Title"
FROM comments
LEFT JOIN posts ON comments.post_id = posts.id
-- WHERE posts.title = 'Post Title';

-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the post was created before January 1, 2015
-- 38ms(+6ms) 9126rows
SELECT posts.title AS "post_title", posts.url AS "post_url", comments.body AS "comment_body"
FROM comments
LEFT JOIN posts ON comments.post_id = posts.id
WHERE posts.created_at < '2015-01-01';

-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the post was created after January 1, 2015
-- 44ms(+4ms) 10603rows
SELECT posts.title AS "post_title", posts.url AS "post_url", comments.body AS "comment_body"
FROM comments
LEFT JOIN posts ON comments.post_id = posts.id
WHERE posts.created_at > '2015-01-01';

-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the comment body contains the word 'USB'
-- 10ms(+1ms) 728rows
SELECT posts.title AS "post_title", posts.url AS "post_url", comments.body AS "comment_body"
FROM comments
LEFT JOIN posts ON comments.post_id = posts.id
WHERE comments.body LIKE '%USB%';

-- 1. Create a query to get the post title (aliased as post_title), first name of the author of the post, last name of the author of the post, and comment body (aliased to comment_body), where the comment body contains the word 'matrix' ( should have 855 results )
-- 26ms(+1ms) 855rows
SELECT posts.title AS "post_title", users.first_name, users.last_name, comments.body AS "comment_body"
FROM comments
LEFT JOIN posts ON comments.post_id = posts.id
LEFT JOIN users ON comments.user_id = users.id
WHERE comments.body LIKE '%matrix%';

-- 1. Create a query to get the first name of the author of the comment, last name of the author of the comment, and comment body (aliased to comment_body), where the comment body contains the word 'SSL' and the post content contains the word 'dolorum' ( should have 102 results )
-- 1.511s(+1ms) 102rows
-- 71ms 102rows
SELECT users.first_name, users.last_name, comments.body AS "comment_body"
FROM comments
LEFT JOIN users ON comments.user_id = users.id
LEFT JOIN posts ON comments.post_id = posts.id
WHERE comments.body LIKE '%SSL%' AND posts.content LIKE '%dolorum%';

-- 1. Create a query to get the first name of the author of the post (aliased to post_author_first_name), last name of the author of the post (aliased to post_author_last_name), the post title (aliased to post_title), username of the author of the comment (aliased to comment_author_username), and comment body (aliased to comment_body), where the comment body contains the word 'SSL' or 'firewall' and the post content contains the word 'nemo' ( should have 218 results )
-- 82ms 218rows
SELECT users.first_name AS "post_author_first_name", users.last_name AS "post_author_last_name", posts.title AS "post_title", users.username AS "comment_author_username", comments.body AS "comment_body"
FROM posts
JOIN users ON posts.user_id = users.id
JOIN comments ON posts.id = comments.post_id
WHERE comments.body LIKE ANY (array['%SSL%', '%firewall%']) AND posts.content LIKE '%nemo%';

-- ### Additional Queries

-- If you finish early, perform and record the following SQL statements in `joins.sql` using these higher level requirements.

-- 1. Count how many comments have been written on posts that have been created after July 14, 2015 ( should have one result, the value of the count should be 27)
-- 117ms 1row value 27
SELECT COUNT (comments.created_at)
FROM posts
JOIN comments ON posts.id = comments.post_id
WHERE posts.created_at > '2015-07-14';

-- 1. Find all users who comment about 'programming' ( should have 336 results)
-- 89ms 337rows
SELECT users.* 
FROM users
JOIN comments ON users.id = comments.user_id
WHERE comments.body LIKE '%programming%';