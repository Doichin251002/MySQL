USE softuni_imdb;

# Query 10. Function History movies
CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50))
    RETURNS INT
    DETERMINISTIC
BEGIN
    DECLARE current_actor_id INT;
    SET current_actor_id = (SELECT id
                            FROM actors
                            WHERE CONCAT_WS(' ', first_name, last_name) LIKE full_name);

    RETURN (SELECT COUNT(ma.movie_id)
            FROM movies_actors ma
                     JOIN actors a ON ma.actor_id = a.id
                     JOIN genres_movies gm ON ma.movie_id = gm.movie_id
                     JOIN genres g ON g.id = gm.genre_id
            WHERE a.id LIKE current_actor_id
              AND g.name LIKE 'History');
END;

SELECT udf_actor_history_movies_count('Stephan Lundberg') AS 'history_movies';

SELECT udf_actor_history_movies_count('Jared Di Batista') AS 'history_movies';

# Query 11.	Procedure Movie awards
CREATE PROCEDURE udp_award_movie(movie_title VARCHAR(50))
BEGIN
    UPDATE movies
        JOIN movies_actors ma ON movies.id = ma.movie_id
        JOIN actors a ON a.id = ma.actor_id
    SET a.awards = a.awards + 1
    WHERE ma.actor_id IN (SELECT actor_id FROM movies_actors)
      AND movies.title = movie_title;
END;

CALL udp_award_movie('Tea For Two');