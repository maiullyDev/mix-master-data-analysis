-- tabela unificada

WITH 
spotify_clean AS (
  SELECT
    UPPER(REPLACE(track_id, ':', '')) AS track_id,
    UPPER(REPLACE(track_name, '�', '')) AS track_name,
    UPPER(REPLACE(artist_s__name, '�', '')) AS artist_s__name,
    artist_count,
    DATE(released_year,released_month,released_day) AS release_date,
    in_spotify_playlists,
    in_spotify_charts,
    streams
  FROM `hipoteses-proj2.dados_proj2.track_in_spotify`
  QUALIFY streams IS NOT NULL
    AND ROW_NUMBER() OVER(PARTITION BY track_name, artist_s__name ORDER BY track_name, artist_s__name) = 1
),
competition_clean AS (
  SELECT 
    *,
    COALESCE(in_shazam_charts, moda_coluna) AS in_shazam_charts_moda
  FROM 
    `hipoteses-proj2.dados_proj2.track_in_competition`,
    (SELECT in_shazam_charts AS moda_coluna
     FROM `hipoteses-proj2.dados_proj2.track_in_competition`
     GROUP BY in_shazam_charts
     ORDER BY COUNT(in_shazam_charts) DESC
     LIMIT 1) AS moda_subquery
),
technical_info AS (
  SELECT 
  * EXCEPT (key)
  FROM `hipoteses-proj2.dados_proj2.track_technical_info`
),
conversao_stream AS (
  SELECT 
  *,
  CAST(streams AS INT64) stream -- Faz a conversão para INTEGER
  FROM (
    SELECT
      *
    FROM
      `hipoteses-proj2.dados_proj2.track_in_spotify`
    WHERE
      SAFE_CAST(streams AS INT64) IS NOT NULL)
) 

SELECT 
  spotify_clean.track_id,
  spotify_clean.track_name,
  spotify_clean.artist_s__name,
  spotify_clean.artist_count,
  spotify_clean.release_date,
  spotify_clean.in_spotify_playlists,
  spotify_clean.in_spotify_charts,
  competition_clean.in_apple_playlists,
  competition_clean.in_apple_charts,
  competition_clean.in_deezer_playlists,
  competition_clean.in_deezer_charts,
  competition_clean.in_shazam_charts_moda,
  spotify_clean.in_spotify_playlists + competition_clean.in_deezer_playlists + competition_clean.in_deezer_playlists AS total_playlists,
  conversao_stream.stream ,
  technical_info.bpm,
  technical_info.danceability__,
  technical_info.valence__,
  technical_info.energy__,
  technical_info.acousticness__,
  technical_info.instrumentalness__,
  technical_info.liveness__,
  technical_info.speechiness__,
  technical_info.mode
FROM competition_clean
JOIN spotify_clean ON competition_clean.track_id = spotify_clean.track_id
JOIN technical_info ON competition_clean.track_id = technical_info.track_id
JOIN conversao_stream ON competition_clean.track_id = conversao_stream.track_id 