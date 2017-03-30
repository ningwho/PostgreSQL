-- Perform a left outer join from the project table to the project_users_tech table - which projects has no associated tech?
select
	*
from
	project
left outer join
	project_uses_tech on project_uses_tech.project_id = project.id;


-- Based on the previous query, get the count of the number of project that use each tech.
select
	project.*,
	count(project_uses_tech.tech_id)
from
	project
left outer join
	project_uses_tech on project_uses_tech.project_id = project.id
group by
	project.id;

-- Perform a left outer join from the tech table to the project_uses_tech table - which techs has no associated project?
SELECT
  name, count(tech_id)
FROM
  tech
LEFT OUTER JOIN
  project_uses_tech
ON
  project_uses_tech.tech_id = tech.id
GROUP BY
  tech.id

-- Based on the previous query, get the count of the number of techs used by each project.
SELECT
  name, count(tech_id)
FROM
  tech
LEFT OUTER JOIN
  project_uses_tech
ON
  project_uses_tech.tech_id = tech.id
GROUP BY
  tech.id

-- which ones have zero counts?
SELECT
	*
FROM
	(SELECT
		name, count(tech_id)
	FROM
		tech
	LEFT OUTER JOIN
		project_uses_tech
	ON
		project_uses_tech.tech_id = tech.id
	GROUP BY
		tech.id)x
WHERE
	count = 0;
-- or
SELECT
	name, tech_id
FROM
	tech
LEFT OUTER JOIN
	project_uses_tech
ON
	project_uses_tech.tech_id = tech.id
where
	project_uses_tech.tech_id is NULL

-- 3-way join
select
	*
from
	project
left outer join
	project_uses_tech on project_uses_tech.project_id = project.id
left outer join
	tech on project_uses_tech.tech_id = tech.id;

-- distinct techs that have some project
select
	distinct(tech.name)
from
	project
inner join
	project_uses_tech on project_uses_tech.project_id = project.id
inner join
	tech on project_uses_tech.tech_id = tech.id;

-- distinct techs that have no project
select
	distinct(tech.name)
from
	project
right outer join
	project_uses_tech on project_uses_tech.project_id = project.id
right outer join
	tech on project_uses_tech.tech_id = tech.id
where
	project_id is NULL;

-- Order the projects by how many tech it uses.
select *
from
	(select
		project.id,
		project.name,
		count(project_uses_tech.tech_id)
	from
		project
	left outer join
		project_uses_tech on project_uses_tech.project_id = project.id
	group by
		project.id) project_by_tech_count
order by
	count desc;
-- you actually don't need a subselect:
select
	project.id,
	project.name,
	count(project_uses_tech.tech_id) as my_count
from
	project
left outer join
	project_uses_tech on project_uses_tech.project_id = project.id
group by
	project.id
order by
	my_count;
