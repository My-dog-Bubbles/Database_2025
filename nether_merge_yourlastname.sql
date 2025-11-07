select * from Fortress1;
select * from Fortress2;

-- Q1
select mob_name
    from Fortress1
    where spawns = (select max(spawns) from Fortress1);

-- Q2
select mob_name, spawns 
    from Fortress1 
    where spawns > any (select spawns from Fortress2);

-- Q3
select mob_name, Biome_id 
    from Fortress1 
    where biome_id in (select biome_id from Fortress2) 
    and mob_name in (select mob_name from Fortress2);

-- Q4 not work
select fl.mob_name, fl.biome_id, fl.spawns, a.Biome_avg, case 
                                                        when fl.spawns > biome_avg then 'Above'
                                                        when fl.spawns < biome_avg then 'Below'
                                                        else 'Equal'
                                                        end as Status
    from Fortress1 fl, (select biome_id, avg(spawns) as biome_avg from Fortress1 group by biome_id) a
    where fl.biome_id = a.biome_id;

-- Q5
select fl.mob_name 
    from Fortress1 fl, (select avg(spawns) 
                            as biome_avg 
                            from Fortress2
                                ) b, 
                                    (select avg(spawns) 
                                     as biome_avg 
                                     from Fortress1 
                                     ) a
        where fl.spawns > all ((a.Biome_avg+b.Biome_avg)/2);

-- Q6
with av1 as(select avg(spawns) 
                as biome_avg 
                from Fortress1 
                ), 
     av2 as (select avg(spawns) 
                as biome_avg 
                from Fortress2)
select f1.mob_name, round(av1.Biome_avg,2) "F1_AVG", round(av2.Biome_avg,2) "F2_AVG"
 from av1, av2, Fortress1 f1 left join Fortress2 f2 on f1.mob_name = f2.mob_name 
 order by f1.biome_id, f2.biome_id;

-- Q7 - Help
insert into Fortress1 (Mob_name, Biome_id, Spawns, Last_seen)
    select Mob_name, Biome_id, Spawns, Last_seen
    from Fortress2 f2
    where not exists(select Mob_name
                        from Fortress1 f1
                        where f1.mob_name = f2.mob_name
                        and f1.biome_id = f2.biome_id);

-- Q8
Merge into Fortress1 F1 
    using Fortress2 F2 
    on (F1.mob_name = F2.mob_name) 
   when matched then
    update set F1.spawns = F2.spawns, F1.Last_seen = F2.Last_seen
   when not matched then
    insert (mob_name, Biome_id, spawns, Last_seen)
     values (F2.mob_name, F2.Biome_id, F2.spawns, F2.Last_seen);