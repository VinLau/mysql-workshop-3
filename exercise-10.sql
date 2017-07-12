UPDATE electronicmail SET type = (
   CASE
      WHEN type = "HOME" then "WORK"
      WHEN type = "WORK" then "HOME"
   END
);
