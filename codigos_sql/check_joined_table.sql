-- Código usado para contar o número de células vazias:
SELECT COUNT(*) AS numNulls
  FROM `hipoteses-proj2.dados_proj2.joined_table`
  WHERE mode IS NULL

-- Código usado para contar o número de células duplicadas:
SELECT track_id, COUNT(track_id)
  FROM `hipoteses-proj2.dados_proj2.joined_table`
  GROUP BY track_id
  HAVING COUNT(track_id) > 1;

-- Código para verificar linhas em que track_name, artist_s__name se repetem:
SELECT track_name, artist_s__name, COUNT(*) as count
    FROM `hipoteses-proj2.dados_proj2.joined_table`
    GROUP BY track_name, artist_s__name
    HAVING count > 1