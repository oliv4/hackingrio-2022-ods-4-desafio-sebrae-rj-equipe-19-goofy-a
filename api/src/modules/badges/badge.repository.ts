import { EntityRepository, Repository } from 'typeorm';
import { BadgesEntity } from './badge.entity';

@EntityRepository(BadgesEntity)
export class BadgesRepository extends Repository<BadgesEntity> {
  async findStudentCertificate(
    refId: string,
    studentId: string,
  ): Promise<BadgesEntity> {
    return await this.findOne({
      where: {
        typeRef: refId,
        studentId,
        isActive: true,
      },
    });
  }

  async new(): Promise<BadgesEntity> {
    const badge = new BadgesEntity();
    badge.id = crypto.randomUUID();
    return this.create(badge);
  }
}
