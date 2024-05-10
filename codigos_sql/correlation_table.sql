-- Tabela de correlações

WITH 
count_musics AS (
  SELECT 
    artist_s__name, 
    COUNT(artist_s__name) AS total_musics, 
    SUM(stream) AS total_streams
  FROM `hipoteses-proj2.dados_proj2.joined_table_quartiles`
  GROUP BY artist_s__name
  ORDER BY total_musics DESC, total_streams DESC
),
count_musics_corr AS (
  SELECT 
    CORR(total_musics, total_streams) AS corr_stream_total_musics
  FROM count_musics
)

SELECT
  CORR(in_spotify_charts , in_apple_charts) AS corr_spotify_apple_charts,
  CORR(in_spotify_charts,in_deezer_charts) AS corr_spotify_deezer_charts,
  CORR(in_spotify_charts,in_shazam_charts_moda) AS corr_spotify_shazam,
  CORR(stream, total_playlists) AS corr_stream_playlists,
  CORR(stream,bpm) AS corr_stream_bpm,
  CORR(stream, danceability__) AS corr_stream_danceability,
  CORR(stream, valence__) AS corr_stream_valence,
  CORR(stream, energy__) AS corr_stream_energy,
  CORR(stream, acousticness__) AS corr_stream_acousticness,
  CORR(stream, instrumentalness__) AS corr_stream_instrumentalness,
  CORR(stream, liveness__) AS corr_stream_liveness,
  CORR(stream, speechiness__) AS corr_stream_speecness,
  MAX(count_musics_corr.corr_stream_total_musics) AS corr_stream_total_musics
FROM `hipoteses-proj2.dados_proj2.joined_table_quartiles` A, count_musics_corr;