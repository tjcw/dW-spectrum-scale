
function expand_hosts
{
  for n
  do echo -n "${n}-ib0.c699.net "
  done
} 
#base_hosts="c699c054 c699c055 c699c056 c699c057"
#base_hosts="c699c003 \
#c699c004 \
#c699c005 \
#c699c006 \
#c699c007 \
#c699c008 \
#c699c009 \
#c699c010 \
#c699c011 \
#c699c012 \
#c699c015 \
#c699c016 \
#c699c017 \
#c699c018 \
#c699c019 \
#c699c020 \
#c699c021 \
#c699c022 \
#c699c023 \
#c699c024 \
#c699c026 \
#c699c027 \
#c699c030 \
#c699c031 \
#c699c033 \
#c699c034 \
#c699c035 \
#c699c036 \
#c699c037 \
#c699c038 \
#c699c039 \
#c699c040 \
#c699c041 \
#c699c042 \
#c699c043 \
#c699c044 \
#c699c045 \
#c699c046 \
#c699c047 \
#c699c048 \
#c699c049 \
#c699c050 \
#c699c051 \
#c699c052 \
#c699c053"

base_hosts="c699c010 \
c699c011 \
c699c012 \
c699c015 \
c699c016 c699c017 c699c019 c699c040 c699c041 c699c042 c699c043 c699c044 c699c045 c699c020 \
c699c021 c699c022"

hosts="$(expand_hosts ${base_hosts})"
