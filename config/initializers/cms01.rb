Rails.application.configure do
  config.cms01 = {
    staff: { host: "cms01.example.com", path: "" },
    admin: { host: "cms01.example.com", path: "admin" },
    customer: { host: "cms01.example.com", path: "mypage" }
  }
end