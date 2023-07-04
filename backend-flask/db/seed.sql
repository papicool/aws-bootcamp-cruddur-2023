-- this file was manually created
INSERT INTO public.users (display_name, handle, email, cognito_user_id)
VALUES
  ('Papa Moussa FALL', 'papamfall' ,'papemfall@gmail.com','MOCK'),
  ('Sokhna Ngom', 'sokhnangom', 'sokhnangom2001@gmail.com' ,'MOCK');


 -- ('pmf', 'pmf' ,'papemfall@gmail.com','MOCK');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'andrewbrown' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  ),
  (
    (SELECT uuid from public.users WHERE users.handle = 'altbrown' LIMIT 1),
    'I am the other!',
    current_timestamp + interval '10 day'
  );