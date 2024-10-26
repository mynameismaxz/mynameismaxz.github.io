---
title: 'บันทึกเกี่ยวกับ Traefik v2 ตอนที่ 1'
date: 2024-10-26T16:30:08+07:00
author: "Me"
draft: true
ShowTOC: true
TocOpen: false
UseHugoToc: true
tags: ["Traefik", "v2", "Reverse Proxy"]
---

## TL;DR

> {{< collapse summary="**กดเพื่ออ่าน**" >}}

- ในบล็อกนี้จะพูดถึงเรื่องของการทำงาน Traefik v2 เพื่อนำมาใช้งานเพื่อเป็น proxy สำหรับการใช้งานทั่วไป
- ในบล็อกนี้จะพูดถึง Concept ของตัวระบบ Traefik v2 ในเชิงที่ลึกลงไปถึงรายละเอียดแต่ละตัว ได้แก่ EntryPoints, Routers, Middlewares และ Services
- ในบล็อกนี้มีสอนการติดตั้งโดยใช้ Docker Container เพื่อใช้งานบน VPS Server ต่างๆ (เหมาะกับผู้มีพื้นฐานอยู่บ้างแล้ว)

{{</ collapse >}}

## Introduction

หลังจากพอมีเวลาว่างบ้างในช่วงสุดสัปดาห์ เลยได้มีเวลาเข้าไปดูแลเซิฟเวอร์ที่ไม่ค่อยได้เข้าไป Maintain เป็นปี ซึ่งก็เป็นไปตามคาดว่า Service หลายๆ ตัวก็เริ่มจะหมดอายุแล้ว (แต่มันก็ยังทำงานอยู่นะ) เลยได้เวลาที่จะมานั่งแก้ไขให้มันดีขึ้น หนึ่งในนั้นก็คือ "Traefik" ซึ่งใช้งานมานานหลายปี โดยอาจจะมี Restart เนื่องจากไปเปลี่ยนการตั้งค่าบางประการ ซึ่งในช่วงนี้ที่มีเวลา ผมก็เลยถือโอกาสสะสางระบบให้มันจัดการง่ายขึ้น เพื่อรองรับการทำงานที่จะเพิ่มขึ้นในเซิฟเวอร์ในอนาคต และในเมื่อได้มีเวลาในการจัดการระบบเหล่านี้แล้ว ก็เลยถือโอกาสเขียนบล็อกเพื่อเตือนความจำของตัวเองด้วยเลย อาจจะเป็นประโยชน์ต่อผู้ที่อาจจะค้นเข้ามาเจอก็ได้ครับ 😁

## Traefik คืออะไร ?

{{< figure align=center src="https://raw.githubusercontent.com/traefik/traefik/master/docs/content/assets/img/traefik.logo.png" >}}

อธิบายให้สั้นๆ และเข้าใจง่ายๆ นั่นก็คือ เป็น Reverse Proxy ประเภทนึงที่ทำหน้าที่ในการจัดการ Request ต่างๆที่เข้ามายังเซิฟเวอร์ของเรา โดยตัวระบบนั้นบอกใน Document ไว้ว่า
> Traefik is an [open-source](https://github.com/traefik/traefik) Edge Router that makes publishing your services a fun and easy experience. It receives requests on behalf of your system and finds out which components are responsible for handling them.