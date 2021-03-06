with Ada.Text_IO;
with pkg_ada_dtstamp;
with Ada.Real_Time; use Ada.Real_Time;

-- ========================================================
procedure main_ada_tasks_01 
with SPARK_Mode => on
is 

  -- RENAMING STANDARD PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package PADTS   renames pkg_ada_dtstamp;
   package ART     renames Ada.Real_Time;

   Start, Finish : ART.Time; 
   
begin
   PADTS.dtstamp;
   ATIO.Put_Line ("Bismillah 3 times WRY");
   ATIO.Put_Line ("Running inside GNAT Studio Community");

   PADTS.dtstamp; ATIO.Put_Line("Delay next 4.5 seconds");
   PADTS.exec_delay_time (ART.To_Time_Span(4.5));
   
   PADTS.dtstamp; ATIO.Put_Line("Delay next 3 seconds");
   PADTS.exec_delay_sec (3);
      
   PADTS.dtstamp; ATIO.Put_Line("Delay next 3,000 milliseconds");
   PADTS.exec_delay_msec (3_000);
   
   PADTS.dtstamp; ATIO.Put_Line("Delay next 5,000,000 microseconds");
   PADTS.exec_delay_usec (5_000_000);
   
   PADTS.dtstamp; ATIO.Put_Line("Delay next 2,000,000,000 nanoseconds");
   PADTS.exec_delay_nsec (2_000_000_000);  -- BELOW MAX FOR TYPE Positive
   
   -- Test timing overrun
   Start  := ART.Clock;
    
   ATIO.Put_Line("Run first actions."); 
   delay until (Start + ART.To_Time_Span(5.0)); -- DUMMY TEST ACTION DURATION
   ATIO.Put_Line("Run second actions."); 
 
   Finish := ART.Clock;
    
   -- a user-defined exception to catch overrun.
   if (Finish - Start) > ART.To_Time_Span(4.0) then
      ATIO.Put("Raise overrun."); 
      ATIO.Put(" Execution duration = "); 
      ATIO.Put_Line(Duration'Image(To_Duration(Finish-Start))); 
   else 
      ATIO.Put("No overrun."); 
      ATIO.Put(" Execution duration = "); 
      ATIO.Put_Line(Duration'Image(To_Duration(Finish-Start))); 
   end if;
   
   
   
   PADTS.dtstamp;
   ATIO.Put_Line ("Alhamdulillah 3 times WRY");
   
-- ========================================================   
end main_ada_tasks_01;

-- EXECUTION ==============================================
-- /home/wruslan/github/ada-concurrent-01/exec/main_ada_tasks_01.adx
-- 2021-02-19 11:02:05.07148517202 Bismillah 3 times WRY
-- Running inside GNAT Studio Community
-- 2021-02-19 11:02:05.07148531716 Delay next 4.5 seconds
-- 2021-02-19 11:02:09.57648712904 Delay next 3 seconds
-- 2021-02-19 11:02:12.57648922636 Delay next 3,000 milliseconds
-- 2021-02-19 11:02:15.57649140216 Delay next 5,000,000 microseconds
-- 2021-02-19 11:02:20.57649535262 Delay next 2,000,000,000 nanoseconds
-- 2021-02-19 11:02:22.57649749309 Alhamdulillah 3 times WRY
-- [2021-02-19 19:02:22] process terminated successfully, elapsed time: 17.62s

-- gnatprove -P/home/wruslan/github/ada-concurrent-01/ada_tasks_01.gpr -j0 --mode=flow --ide-progress-bar -U
-- Phase 1 of 2: generation of Global contracts ...
-- Phase 2 of 2: analysis of data and information flow ...
-- Summary logged in /home/wruslan/github/ada-concurrent-01/obj/gnatprove/gnatprove.out
-- [2021-02-19 19:04:02] process terminated successfully, elapsed time: 04.05s

-- /home/wruslan/github/ada-concurrent-01/exec/main_ada_tasks_01.adx
-- 2021-02-19 23:26:08.19276892247 Bismillah 3 times WRY
-- Running inside GNAT Studio Community
-- 2021-02-19 23:26:08.19276952188 Delay next 4.5 seconds
-- 2021-02-19 23:26:12.69777176779 Delay next 3 seconds
-- 2021-02-19 23:26:15.69777367969 Delay next 3,000 milliseconds
-- 2021-02-19 23:26:18.69777574352 Delay next 5,000,000 microseconds
-- 2021-02-19 23:26:23.69777824221 Delay next 2,000,000,000 nanoseconds
-- Run first actions.
-- Run second actions.
-- No overrun. Execution duration =  5.000167554
-- 2021-02-19 23:26:30.69778181321 Alhamdulillah 3 times WRY
-- [2021-02-20 07:26:30] process terminated successfully, elapsed time: 22.65s

-- /home/wruslan/github/ada-concurrent-01/exec/main_ada_tasks_01.adx
-- 2021-02-19 23:31:24.06148800388 Bismillah 3 times WRY
-- Running inside GNAT Studio Community
-- 2021-02-19 23:31:24.06148863116 Delay next 4.5 seconds
-- 2021-02-19 23:31:28.56649072051 Delay next 3 seconds
-- 2021-02-19 23:31:31.56649275630 Delay next 3,000 milliseconds
-- 2021-02-19 23:31:34.56649497451 Delay next 5,000,000 microseconds
-- 2021-02-19 23:31:39.56649691432 Delay next 2,000,000,000 nanoseconds
-- Run first actions.
-- Run second actions.
-- Raise overrun. Execution duration =  5.000169507
-- 2021-02-19 23:31:46.56650097247 Alhamdulillah 3 times WRY
-- [2021-02-20 07:31:46] process terminated successfully, elapsed time: 22.63s


