/* =========================================================
   QUERY 1 - Ranking de Professores por Matrículas/Aula
   Objetivo: identificar professores mais demandados
   ========================================================= */

CREATE OR REPLACE VIEW vw_ranking_professores AS
SELECT
  p.id_professor,
  p.nome AS nome_professor,
  COUNT(m.id_matricula) AS total_matriculas,
  COUNT(DISTINCT a.id_aula) AS total_aulas,
  ROUND(
    COUNT(m.id_matricula)::numeric 
    / COUNT(DISTINCT a.id_aula),
    2
  ) AS matriculas_por_aula
FROM professores p
JOIN aulas a
  ON p.id_professor = a.id_professor
LEFT JOIN matriculas m
  ON a.id_aula = m.id_aula
GROUP BY p.id_professor, p.nome;


/* =========================================================
   QUERY 2 - Alunos com Maior Número de Matrículas
   Objetivo: identificar alunos mais ativos
   ========================================================= */

CREATE OR REPLACE VIEW vw_ranking_alunos AS
SELECT
  al.id_aluno,
  al.nome AS nome_aluno,
  COUNT(m.id_matricula) AS total_matriculas
FROM alunos al
LEFT JOIN matriculas m
  ON al.id_aluno = m.id_aluno
GROUP BY al.id_aluno, al.nome;


/* =========================================================
   QUERY 3 - Aulas Mais Procuradas
   Objetivo: identificar aulas com maior demanda
   ========================================================= */

CREATE OR REPLACE VIEW vw_ranking_aulas AS
SELECT
  a.id_aula,
  a."nome_aula" AS nome_aula,
  COUNT(m.id_matricula) AS total_matriculas
FROM aulas a
LEFT JOIN matriculas m
  ON a.id_aula = m.id_aula
GROUP BY a.id_aula, a."nome_aula";
