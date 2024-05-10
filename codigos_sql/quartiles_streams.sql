-- Código para calcular os quartis de streams:

WITH quartiles AS (
  SELECT
    track_id,
    stream,
    NTILE(4) OVER (ORDER BY stream) AS quartiles_streams,
    NTILE(4) OVER (ORDER BY bpm) AS quartiles_bpm,
    NTILE(4) OVER (ORDER BY danceability__) AS quartiles_danceability,
    NTILE(4) OVER (ORDER BY valence__) AS quartiles_valence,
    NTILE(4) OVER (ORDER BY energy__) AS quartiles_energy,
    NTILE(4) OVER (ORDER BY acousticness__) AS quartiles_acousticness,
    NTILE(4) OVER (ORDER BY instrumentalness__) AS quartiles_instrumentalness,
    NTILE(4) OVER (ORDER BY liveness__) AS quartiles_liveness,
    NTILE(4) OVER (ORDER BY speechiness__) AS quartiles_speechiness,
    NTILE(4) OVER (ORDER BY in_spotify_playlists) AS quartiles_spotify_playlists,
    NTILE(4) OVER (ORDER BY in_spotify_charts) AS quartiles_spotify_charts,
    NTILE(4) OVER (ORDER BY in_apple_playlists) AS quartiles_apple_playlists,
    NTILE(4) OVER (ORDER BY in_apple_charts) AS quartiles_apple_charts,
    NTILE(4) OVER (ORDER BY in_deezer_playlists) AS quartiles_deezer_playlists,
    NTILE(4) OVER (ORDER BY in_deezer_charts) AS quartiles_deezer_charts,
    NTILE(4) OVER (ORDER BY in_shazam_charts_moda) AS quartiles_shazam_charts
  FROM `hipoteses-proj2.dados_proj2.unified_table`
)
SELECT
  joined_table.*,
  quartiles.quartiles_streams,
  CASE
    WHEN quartiles.quartiles_streams = 4 THEN 'Alto'
    ELSE 'Baixo'
  END AS streams_classification,

  CASE
    WHEN quartiles_bpm = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS bpm_classification,

  CASE
    WHEN quartiles_danceability = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS danceability_classification,

  CASE
    WHEN quartiles_valence = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS valence_classification,

  CASE
    WHEN quartiles_energy = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS energy_classification,

  CASE
    WHEN quartiles_acousticness = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS acousticness_classification,

  CASE
    WHEN quartiles_instrumentalness = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS instrumentalness_classification,

  CASE
    WHEN quartiles_liveness = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS liveness_classification,

  CASE
    WHEN quartiles_speechiness = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS speechiness_classification,

  CASE
    WHEN quartiles_spotify_playlists = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS spotify_playlists_classification,

  CASE
    WHEN quartiles_spotify_charts = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS spotify_charts_classification,

  CASE
    WHEN quartiles_apple_playlists = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS apple_playlists_classification,

  CASE
    WHEN quartiles_apple_charts = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS apple_charts_classification,

  CASE
    WHEN quartiles_deezer_playlists = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS deezer_playlists_classification,

  CASE
    WHEN quartiles_deezer_charts = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS deezer_charts_classification,

  CASE
    WHEN quartiles_shazam_charts = 4 THEN 'Alto'
    ELSE 'Baixo' 
  END AS shazam_charts_classification

FROM `hipoteses-proj2.dados_proj2.unified_table` joined_table
LEFT JOIN quartiles ON joined_table.track_id = quartiles.track_id;