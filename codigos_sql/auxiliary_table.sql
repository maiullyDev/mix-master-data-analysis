-- Músicas solo

WITH 
solo_songs AS (
  SELECT 
    artist_s__name,
    COUNT(*) AS total_solo_songs,
    AVG(stream) AS avg_streams
  FROM `hipoteses-proj2.dados_proj2.joined_table` 
  WHERE artist_count = 1
  GROUP BY artist_s__name
)

SELECT 
  DISTINCT solo_songs.artist_s__name,
  solo_songs.total_solo_songs,
  solo_songs.avg_streams
FROM `hipoteses-proj2.dados_proj2.joined_table` artist_name
JOIN solo_songs ON artist_name.artist_s__name = solo_songs.artist_s__name;